import SwiftUI

// MARK: - 1️⃣ MODEL
struct VTUModel: Codable {
    let id: Int
    let name: String
    let image_logo: String
    let image1: String
    let description1: String
    let image2: String
    let description2: String
    let image3: String
    let description3: String
}

struct VTUResponse: Codable {
    let success: Bool
    let college: VTUModel
}

// MARK: - 2️⃣ REUSABLE DESCRIPTION BLOCK
struct VTUDescriptionBlock: View {
    let imageURL: String
    let description: String
    let imageWidth: CGFloat
    let imageHeight: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageWidth, height: imageHeight)
                    .clipped()
                    .cornerRadius(12)
                    .shadow(radius: 4)
            } placeholder: {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: imageWidth, height: imageHeight)
            }

            Text(description)
                .font(.body)
                .foregroundColor(.black)
                .padding(.top, 8)
        }
        .padding()
    }
}

// MARK: - 3️⃣ MAIN VTU VIEW WITH REVIEWS
struct VTUView: View {
    @Environment(\.dismiss) var dismiss
    @State private var collegeData: VTUModel?
    @State private var isCourseViewActive = false
    @State private var isLoading = true
    @State private var reviews: [Review] = sampleReviews.shuffled()
    @State private var showReviewSheet = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {

                // Back Button
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 12, height: 20)
                            .padding(6)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)

                if let college = collegeData {
                    // Header Section
                    HStack(spacing: 12) {
                        AsyncImage(url: URL(string: college.image_logo)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(width: 90, height: 70)
                        .cornerRadius(12)
                        .shadow(radius: 4)

                        Text(college.name)
                            .font(.title3)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)

                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(14)
                    .padding(.horizontal)

                    // Description Sections
                    VTUDescriptionBlock(imageURL: college.image1, description: college.description1, imageWidth: 340, imageHeight: 200)
                    VTUDescriptionBlock(imageURL: college.image2, description: college.description2, imageWidth: 340, imageHeight: 200)
                    VTUDescriptionBlock(imageURL: college.image3, description: college.description3, imageWidth: 340, imageHeight: 200)

                    // MARK: - Reviews Section
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

                    // View Courses Button
                    NavigationLink(destination: CourseView(), isActive: $isCourseViewActive) {
                        Button(action: {
                            isCourseViewActive = true
                        }) {
                            Text("View Courses")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(14)
                                .shadow(radius: 2)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 30)

                } else if isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else {
                    Text("Failed to load data.")
                        .foregroundColor(.red)
                        .padding()
                }
            }
        }
        .onAppear {
            fetchCollegeData()
            reviews = sampleReviews.shuffled()
        }
        .sheet(isPresented: $showReviewSheet) {
            WriteReviewView { newReview in
                reviews.insert(newReview, at: 0)
            }
        }
        .navigationBarHidden(true)
        .background(Color.white)
    }

    // MARK: - FETCH DATA
    func fetchCollegeData() {
        guard let url = URL(string: ServiceAPI.vtu_collegeURL) else {
            print("Invalid URL")
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { isLoading = false }

            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(VTUResponse.self, from: data)
                    if decoded.success {
                        DispatchQueue.main.async {
                            self.collegeData = decoded.college
                        }
                    } else {
                        print("Backend success = false")
                    }
                } catch {
                    print("Decoding error:", error.localizedDescription)
                }
            } else {
                print("Network error:", error?.localizedDescription ?? "Unknown error")
            }
        }.resume()
    }
}

// MARK: - 4️⃣ PREVIEW
struct VTUView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VTUView()
        }
    }
}
