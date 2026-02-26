import SwiftUI

// MARK: - Andhra Pradesh College Model
struct APCollege: Identifiable, Decodable {
    let id: String
    let name: String
    let address: String
    let state: String
    let image_url: String

    enum CodingKeys: String, CodingKey {
        case id, name, address, state, image_url
    }

    // Flexible decoder: accepts id as Int or String, safe defaults for missing fields
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let intId = try? container.decode(Int.self, forKey: .id) {
            self.id = String(intId)
        } else if let strId = try? container.decode(String.self, forKey: .id) {
            self.id = strId
        } else {
            self.id = UUID().uuidString
        }

        self.name = (try? container.decode(String.self, forKey: .name)) ?? ""
        self.address = (try? container.decode(String.self, forKey: .address)) ?? ""
        self.state = (try? container.decode(String.self, forKey: .state)) ?? ""
        self.image_url = (try? container.decode(String.self, forKey: .image_url)) ?? ""
    }
}

// MARK: - Andhra Pradesh API Response
struct APAPIResponse: Decodable {
    let success: Bool
    let colleges: [APCollege]?
    let message: String?
}

// MARK: - Andhra Pradesh View
struct AndhraPradeshView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var colleges: [APCollege] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        VStack(alignment: .leading) {
            // Back Button
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
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
                Text("Andhra Pradesh")
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
                                Text(college.state)
                                    .font(.caption)
                                    .foregroundColor(.gray)
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
    func destinationView(for college: APCollege) -> some View {
        let name = college.name.lowercased()

        if name.contains("indian institute of technology") && name.contains("tirupati") {
            IITTirupatiView()
        } else if name.contains("vignan") {
            VignanView()
        } else {
            VStack(spacing: 12) {
                Text("College Details")
                    .font(.headline)
                Text(college.name)
                    .font(.title)
                Text(college.address)
                    .font(.subheadline)
                Text(college.state)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .navigationBarBackButtonHidden(true)
        }
    }

    // MARK: - Fetch from API
    func fetchColleges() {
        guard let url = URL(string: ServiceAPI.ap_collegesURL) else {
            DispatchQueue.main.async {
                self.errorMessage = "Invalid URL"
                self.isLoading = false
            }
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async { self.isLoading = false }

            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received."
                }
                return
            }

            let decoder = JSONDecoder()
            do {
                let apiResponse = try decoder.decode(APAPIResponse.self, from: data)
                DispatchQueue.main.async {
                    if apiResponse.success, let loaded = apiResponse.colleges {
                        self.colleges = loaded
                        self.errorMessage = nil
                    } else {
                        self.errorMessage = apiResponse.message ?? "Failed to load colleges."
                    }
                }
            } catch {
                // Fallback: decode raw array
                do {
                    let fallback = try decoder.decode([APCollege].self, from: data)
                    DispatchQueue.main.async {
                        self.colleges = fallback
                        self.errorMessage = nil
                    }
                } catch {
                    let debugMessage = String(data: data, encoding: .utf8) ?? error.localizedDescription
                    DispatchQueue.main.async {
                        self.errorMessage = "Decoding failed: \(error.localizedDescription)\nResponse: \(debugMessage)"
                    }
                }
            }
        }.resume()
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        AndhraPradeshView()
    }
}
