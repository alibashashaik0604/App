import SwiftUI
import PhotosUI

struct AdminCollege: Identifiable, Codable {
    var id: String
    var name: String
    var location: String
    var state: String
    var imageUrl: String
}

struct AdminPanel: View {
    @State private var colleges: [AdminCollege] = []
    @State private var showForm = false
    @State private var editingCollege: AdminCollege? = nil
    @State private var selectedState = "ap"
    @State private var selectedCollege: AdminCollege? = nil
    @AppStorage("isLoggedIn") var isLoggedIn = true
    let states = ["ap", "ka", "tn_colleges", "ts_colleges"]

    var body: some View {
        NavigationView {
            VStack {
                Picker("State", selection: $selectedState) {
                    ForEach(states, id: \.self) { Text($0.uppercased()).tag($0) }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: selectedState) { _ in fetchColleges() }

                if colleges.isEmpty {
                    ProgressView("Loading...").onAppear { fetchColleges() }
                } else {
                    List {
                        ForEach(colleges) { c in
                            VStack(alignment: .leading) {
                                Text(c.name).font(.headline)
                                Text(c.location).foregroundColor(.gray)
                            }
                            .contextMenu {
                                Button("Edit") {
                                    editingCollege = c
                                    showForm = true
                                }
                                Button("Delete", role: .destructive) {
                                    deleteCollege(id: c.id, state: c.state)
                                }
                                Button("Details") {
                                    selectedCollege = c
                                }
                            }
                        }
                    }
                }

                Button(action: {
                    editingCollege = nil
                    showForm = true
                }) {
                    Label("Add College", systemImage: "plus")
                        .frame(maxWidth: .infinity).padding()
                        .background(Color.blue).foregroundColor(.white).cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .navigationTitle("Admin Panel")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Logout") {
                        isLoggedIn = false
                    }.foregroundColor(.red)
                }
            }
            .sheet(isPresented: $showForm, onDismiss: fetchColleges) {
                CollegeForm(editingCollege: editingCollege, defaultState: selectedState)
            }
            .background(
                NavigationLink(destination: CollegeDetailView(college: selectedCollege), isActive: .constant(selectedCollege != nil)) {
                    EmptyView()
                }.hidden()
            )
        }
    }

    func fetchColleges() {
        guard let url = URL(string: "http://localhost/collegehunt/getcollege.php?state=\(selectedState)") else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let d = data, let decoded = try? JSONDecoder().decode([AdminCollege].self, from: d) {
                DispatchQueue.main.async { colleges = decoded }
            }
        }.resume()
    }

    func deleteCollege(id: String, state: String) {
        guard let url = URL(string: "http://localhost/collegehunt/delete_college.php?id=\(id)&state=\(state)") else { return }
        URLSession.shared.dataTask(with: url) { _, _, _ in
            DispatchQueue.main.async {
                colleges.removeAll { $0.id == id }
            }
        }.resume()
    }
}

struct CollegeForm: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var location = ""
    @State private var state: String
    @State private var image: UIImage? = nil

    var editingCollege: AdminCollege?
    let defaultState: String
    let states = ["ap", "ka", "tn_colleges", "ts_colleges"]

    init(editingCollege: AdminCollege?, defaultState: String) {
        self.editingCollege = editingCollege
        self.defaultState = defaultState
        _state = State(initialValue: editingCollege?.state ?? defaultState)
    }

    var body: some View {
        NavigationView {
            Form {
                Section("College Info") {
                    TextField("Name", text: $name)
                    TextField("Location", text: $location)
                    Picker("State", selection: $state) {
                        ForEach(states, id: \.self) { Text($0.uppercased()).tag($0) }
                    }
                }

                Section("Image") {
                    if let img = image {
                        Image(uiImage: img).resizable().scaledToFit().frame(height: 200)
                    }
                    ImagePicker(image: $image)
                }

                Button(editingCollege == nil ? "Add College" : "Update College") {
                    saveCollege()
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle(editingCollege == nil ? "Add College" : "Edit College")
            .onAppear {
                if let c = editingCollege {
                    name = c.name
                    location = c.location
                }
            }
        }
    }

    func saveCollege() {
        let isEdit = editingCollege != nil
        let endpoint = isEdit ? "update_colleges.php" : "add_colleges.php"
        guard let url = URL(string: "ServiceAPI.BaseURL/\(endpoint)") else { return }

        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        let boundary = UUID().uuidString
        req.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()
        let id = editingCollege?.id ?? UUID().uuidString
        ["id": id, "name": name, "location": location, "state": state].forEach { k, v in
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(k)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(v)\r\n".data(using: .utf8)!)
        }

        if let img = image?.jpegData(compressionQuality: 0.8) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(id).jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(img)
            body.append("\r\n".data(using: .utf8)!)
        }

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        req.httpBody = body

        URLSession.shared.uploadTask(with: req, from: body) { _, _, _ in
            DispatchQueue.main.async { dismiss() }
        }.resume()
    }
}

struct CollegeDetailView: View {
    var college: AdminCollege?

    var body: some View {
        if let college = college {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if let url = URL(string: "http://localhost/collegehunt/uploads/\(college.id).jpg") {
                        AsyncImage(url: url) { phase in
                            if let image = phase.image {
                                image.resizable().scaledToFit()
                            } else if phase.error != nil {
                                Text("Error loading image")
                            } else {
                                ProgressView()
                            }
                        }
                        .frame(height: 200)
                        .cornerRadius(12)
                    }

                    Text("Name: \(college.name)").font(.title2)
                    Text("Location: \(college.location)").foregroundColor(.secondary)
                    Text("State: \(college.state.uppercased())").font(.headline)

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("College Details")
        } else {
            Text("No college selected").foregroundColor(.gray)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker
        init(_ parent: ImagePicker) { self.parent = parent }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let provider = results.first?.itemProvider,
                  provider.canLoadObject(ofClass: UIImage.self) else { return }

            provider.loadObject(ofClass: UIImage.self) { image, _ in
                self.parent.image = image as? UIImage
            }
        }
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
}

struct AdminPanel_Previews: PreviewProvider {
    static var previews: some View {
        AdminPanel()
    }
}
