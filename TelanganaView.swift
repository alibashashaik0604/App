import SwiftUI

// MARK: - Telangana College Model
struct TelanganaCollege: Identifiable, Decodable {
    let id: String
    let name: String
    let address: String
    let state: String
    let image_url: String

    enum CodingKeys: String, CodingKey {
        case id, name, address, state, image_url
    }

    // Flexible decoder: accepts id as Int or String and provides safe defaults for missing fields
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

// MARK: - Telangana API Response
struct TelanganaAPIResponse: Decodable {
    let success: Bool
    let colleges: [TelanganaCollege]?
    let message: String?
}

// MARK: - Telangana View
struct Telangana: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var colleges: [TelanganaCollege] = []
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
                Text("Telangana")
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
    func destinationView(for college: TelanganaCollege) -> some View {
        let name = college.name.lowercased()

        if name.contains("indian institute of technology") && name.contains("hyderabad") {
            IITHyderabadView()
        } else if name.contains("international institute of information technology") || name.contains("iiit") {
            IIITHyderabadView()
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
        guard let url = URL(string: ServiceAPI.ts_collegesURL) else {
            DispatchQueue.main.async(execute: {
                self.errorMessage = "Invalid URL"
                self.isLoading = false
            })
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            // Stop loading state immediately on main thread
            DispatchQueue.main.async(execute: {
                self.isLoading = false
            })

            if let error = error {
                DispatchQueue.main.async(execute: {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                })
                return
            }

            guard let data = data else {
                DispatchQueue.main.async(execute: {
                    self.errorMessage = "No data received."
                })
                return
            }

            // Try to decode the expected wrapper response first.
            let decoder = JSONDecoder()
            do {
                let apiResponse = try decoder.decode(TelanganaAPIResponse.self, from: data)
                DispatchQueue.main.async(execute: {
                    if apiResponse.success, let loaded = apiResponse.colleges {
                        self.colleges = loaded
                        self.errorMessage = nil
                    } else {
                        self.errorMessage = apiResponse.message ?? "Failed to load colleges."
                    }
                })
            } catch {
                // Fallback: some servers return a raw array instead of wrapper
                do {
                    let fallback = try decoder.decode([TelanganaCollege].self, from: data)
                    DispatchQueue.main.async(execute: {
                        self.colleges = fallback
                        self.errorMessage = nil
                    })
                } catch {
                    // Final fallback — provide helpful debug message
                    let debugMessage = String(data: data, encoding: .utf8) ?? error.localizedDescription
                    DispatchQueue.main.async(execute: {
                        self.errorMessage = "Decoding failed: \(error.localizedDescription)\nResponse: \(debugMessage)"
                    })
                }
            }
        }.resume()
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        Telangana()
    }
}
