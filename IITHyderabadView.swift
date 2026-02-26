import SwiftUI

// MARK: - 1️⃣ MODEL
struct IITHModel: Codable {
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

struct IITHResponse: Codable {
    let success: Bool
    let college: IITHModel
}

// MARK: - 2️⃣ REUSABLE DESCRIPTION BLOCK
struct IITHDescriptionBlock: View {
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



// MARK: - 4️⃣ MAIN IITH VIEW
struct IITHyderabadView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var collegeData: IITHModel?
    @State private var isCourseViewActive = false
    @State private var isLoading = true
    @State private var reviews: [Review] = sampleReviews
    @State private var showReviewSheet = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {

                // Back Button
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
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

                if let college = collegeData {
                    // Logo + Name
                    HStack(spacing: 12) {
                        AsyncImage(url: URL(string: college.image_logo)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(width: 100, height: 75)
                        .cornerRadius(10)

                        Text(college.name)
                            .font(.headline)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    // Description Blocks
                    IITHDescriptionBlock(
                        imageURL: college.image1,
                        description: college.description1,
                        imageWidth: UIScreen.main.bounds.width - 40,
                        imageHeight: 190
                    )

                    IITHDescriptionBlock(
                        imageURL: college.image2,
                        description: college.description2,
                        imageWidth: UIScreen.main.bounds.width - 50,
                        imageHeight: 175
                    )

                    IITHDescriptionBlock(
                        imageURL: college.image3,
                        description: college.description3,
                        imageWidth: UIScreen.main.bounds.width - 60,
                        imageHeight: 165
                    )

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

                    // View Courses Button
                    NavigationLink(destination: CourseView(), isActive: $isCourseViewActive) {
                        Button(action: {
                            isCourseViewActive = true
                        }) {
                            Text("View Courses")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                } else if isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else {
                    Text("Failed to load data.")
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .padding(.bottom, 40)
        }
        .onAppear(perform: fetchCollegeData)
        .background(Color.white)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showReviewSheet) {
            WriteReviewView { newReview in
                reviews.insert(newReview, at: 0)
            }
        }
    }

    // MARK: - 5️⃣ FETCH DATA FROM API
    func fetchCollegeData() {
        guard let url = URL(string: ServiceAPI.iit_hyderabadURL) else {
            print("Invalid URL")
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { isLoading = false }
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(IITHResponse.self, from: data)
                    if decoded.success {
                        DispatchQueue.main.async {
                            self.collegeData = decoded.college
                        }
                    } else {
                        print("Fetch failed: success == false")
                    }
                } catch {
                    print("Decoding failed:", error.localizedDescription)
                    if let raw = String(data: data, encoding: .utf8) {
                        print("Raw Response:\n\(raw)")
                    }
                }
            } else {
                print("Network error:", error?.localizedDescription ?? "Unknown error")
            }
        }.resume()
    }
}



// MARK: - 7️⃣ PREVIEW
struct IITHyderabadView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            IITHyderabadView()
        }
    }
}
