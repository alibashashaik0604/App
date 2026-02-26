import SwiftUI

// MARK: - Models

struct IITTirupatiCollege: Codable {
    let name: String
    let image_logo: String
    let image1: String
    let image2: String
    let image3: String
    let description1: String
    let description2: String
    let description3: String
}

struct IITTirupatiResponse: Codable {
    let success: Bool
    let college: IITTirupatiCollege?
}

// MARK: - Main View

struct IITTirupatiView: View {
    @Environment(\.dismiss) var dismiss
    @State private var college: IITTirupatiCollege?
    @State private var isLoading = true
    @State private var errorMessage = ""

    @State private var reviews: [Review] = sampleReviews.shuffled()
    @State private var showReviewSheet = false

    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView("Loading...")
                    .padding()
            } else if let college = college {
                VStack(alignment: .leading, spacing: 20) {
                    // Back button
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
                        AsyncImage(url: URL(string: college.image_logo)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 90, height: 70)
                        .cornerRadius(10)

                        Text(college.name)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)

                        Spacer()
                    }
                    .padding(.horizontal)

                    // Descriptions
                    CcollegeBlock(imageURL: college.image1, text: college.description1)
                    CcollegeBlock(imageURL: college.image2, text: college.description2)
                    CcollegeBlock(imageURL: college.image3, text: college.description3)

                    // MARK: - Reviews
                    HStack {
                        Text("Student Reviews")
                            .font(.headline)
                        Spacer()
                        Button(action: {
                            showReviewSheet = true
                        }) {
                            Label("Write Review", systemImage: "square.and.pencil")
                                .font(.subheadline)
                                .padding(8)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)

                    ReviewCarouselView(reviews: reviews)
                        .padding(.bottom)

                    // View Courses
                    NavigationLink(destination: CourseView()) {
                        Text("View Courses")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(14)
                            .padding(.horizontal)
                    }
                }
                .padding(.bottom, 30)
            } else {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear(perform: fetchCollegeData)
        .sheet(isPresented: $showReviewSheet) {
            WriteReviewView { newReview in
                reviews.insert(newReview, at: 0)
            }
        }
        .navigationBarHidden(true)
        .background(Color.white)
    }

    func fetchCollegeData() {
        guard let url = URL(string: ServiceAPI.iit_tirupatiURL) else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }

                guard let data = data else {
                    self.errorMessage = "No data"
                    return
                }

                do {
                    let response = try JSONDecoder().decode(IITTirupatiResponse.self, from: data)
                    if response.success, let college = response.college {
                        self.college = college
                    } else {
                        self.errorMessage = "College not found"
                    }
                } catch {
                    self.errorMessage = "Decode error: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

// MARK: - Description Block

struct CcollegeBlock: View {
    let imageURL: String
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            AsyncImage(url: URL(string: imageURL)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 180)
            .cornerRadius(12)

            Text(text)
                .font(.body)
                .foregroundColor(.primary)
        }
        .padding(.horizontal)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        IITTirupatiView()
    }
}
