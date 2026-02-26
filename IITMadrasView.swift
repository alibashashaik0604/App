import SwiftUI

// MARK: - Models

struct IITMadrasCollege: Codable, Identifiable {
    let id: String?
    let name: String
    let image_logo: String?
    let image1: String?
    let image2: String?
    let image3: String?
    let description1: String?
    let description2: String?
    let description3: String?
}

struct IITMadrasResponse: Codable {
    let success: Bool
    let college: IITMadrasCollege?
    let message: String?
}

// MARK: - College Image & Description Block

struct IITCollegeBlockView: View {
    let imageURL: String?
    let description: String?

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if let urlString = imageURL,
               let url = URL(string: urlString),
               !urlString.isEmpty {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 120, height: 90)
                .cornerRadius(8)
                .clipped()
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 120, height: 90)
                    .cornerRadius(8)
            }

            Text(description ?? "No description available.")
                .font(.body)
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal)
    }
}

// MARK: - Main View

struct IITMadrasView: View {
    @Environment(\.dismiss) var dismiss
    @State private var college: IITMadrasCollege?
    @State private var isLoading = true
    @State private var errorMessage = ""

    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView("Loading...")
                    .padding()
            } else if let college = college {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.blue)
                                .padding()
                        }
                        Spacer()
                    }

                    // College header
                    HStack(spacing: 12) {
                        if let logo = college.image_logo,
                           let url = URL(string: logo),
                           !logo.isEmpty {
                            AsyncImage(url: url) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 90, height: 70)
                            .cornerRadius(10)
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 90, height: 70)
                                .cornerRadius(10)
                        }

                        Text(college.name)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)

                        Spacer()
                    }
                    .padding(.horizontal)

                    // Description blocks
                    IITCollegeBlockView(imageURL: college.image1, description: college.description1)
                    IITCollegeBlockView(imageURL: college.image2, description: college.description2)
                    IITCollegeBlockView(imageURL: college.image3, description: college.description3)

                    Spacer()
                }
                .padding(.bottom, 30)
            } else {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear(perform: fetchCollegeData)
        .navigationBarHidden(true)
        .background(Color.white)
    }

    // MARK: - Fetch College Data
    func fetchCollegeData() {
        guard let url = URL(string: ServiceAPI.iit_madrasURL) else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                isLoading = false

                if let error = error {
                    errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    errorMessage = "No data received"
                    return
                }

                // Log raw JSON
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("🔍 Raw JSON:\n\(jsonString)")
                }

                do {
                    let response = try JSONDecoder().decode(IITMadrasResponse.self, from: data)
                    if response.success, let college = response.college {
                        self.college = college
                    } else {
                        errorMessage = response.message ?? "College not found"
                    }
                } catch {
                    errorMessage = "Decode error: \(error.localizedDescription)"
                    print("❌ JSON Decode Error:", error)
                }
            }
        }.resume()
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        IITMadrasView()
    }
}
