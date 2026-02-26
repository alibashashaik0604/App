import SwiftUI

// MARK: - Models

struct TNCollegeResponse: Decodable {
    let success: Bool
    let colleges: [TamilnaduCollege]?
    let message: String?
}

struct TamilnaduCollege: Identifiable, Decodable {
    let id: String       // changed to String because PHP/MySQL often return "id":"1"
    let name: String
    let address: String
    let state: String
    let image_url: String
}

// MARK: - Tamilnadu View

struct Tamilnadu: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var colleges: [TamilnaduCollege] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        VStack(alignment: .leading) {
            // Back Button
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image("image321")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(6)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }
                Spacer()
            }
            .padding(.top)

            // Title
            Text("List of Colleges As You Interest In")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)

            // Location
            HStack {
                Spacer()
                Image("location")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("Tamilnadu")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)

            // College List
            if isLoading {
                ProgressView("Loading Colleges...")
                    .padding()
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(colleges) { college in
                    NavigationLink(destination: destinationView(for: college)) {
                        HStack {
                            AsyncImage(url: URL(string: college.image_url)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.gray.opacity(0.2)
                            }
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)

                            VStack(alignment: .leading) {
                                Text(college.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text(college.address)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.leading, 10)
                        }
                        .padding(.vertical, 10)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: fetchColleges)
    }

    // MARK: - Navigation Logic
    @ViewBuilder
    func destinationView(for college: TamilnaduCollege) -> some View {
        let name = college.name.lowercased()

        if name.contains("indian institute of technology") && name.contains("madras") {
            IITMadrasView()
        } else if name.contains("national institute of technology") || name.contains("tiruchirappalli") || name.contains("nitt") {
            NITTiruchirappalliView()
        } else {
            VStack {
                Text("College Details")
                Text(college.name)
                    .font(.title)
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    // MARK: - Fetch from API
    func fetchColleges() {
        guard let url = URL(string: ServiceAPI.tn_collegesURL) else {
            self.errorMessage = "Invalid URL"
            self.isLoading = false
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async(execute: {
                self.isLoading = false

                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }

                guard let data = data else {
                    self.errorMessage = "No data received."
                    return
                }

                do {
                    let response = try JSONDecoder().decode(TNCollegeResponse.self, from: data)
                    if response.success, let fetchedColleges = response.colleges {
                        self.colleges = fetchedColleges
                        self.errorMessage = nil
                    } else {
                        self.errorMessage = response.message ?? "Failed to load colleges."
                    }
                } catch {
                    self.errorMessage = "Decoding failed: \(error.localizedDescription)"
                }
            })
        }.resume()
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        Tamilnadu()
    }
}
