import SwiftUI

// MARK: - 1️⃣ College Model
struct CollegeModel: Codable {
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

struct CollegeResponse: Codable {
    let success: Bool
    let college: CollegeModel
}

// MARK: - 2️⃣ Student Review Model
struct StudentReview: Identifiable {
    let id = UUID()
    let name: String
    let rating: Int
    let comment: String
}

// MARK: - 3️⃣ Description Block View
struct CollegeDescriptionBlock: View {
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

// MARK: - 4️⃣ Review Card
struct ReviewCard1: View {
    let review: StudentReview

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(review.name)
                .font(.headline)

            HStack(spacing: 2) {
                ForEach(0..<5) { index in
                    Image(systemName: index < review.rating ? "star.fill" : "star")
                        .foregroundColor(index < review.rating ? .yellow : .gray)
                        .font(.caption)
                }
            }

            Text("“\(review.comment)”")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(width: 250)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

// MARK: - 5️⃣ Review Section with Button Action
struct StudentReviewSection: View {
    let reviews: [StudentReview]
    let onWriteReviewTap: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Student Reviews")
                    .font(.headline)
                Spacer()
                Button(action: onWriteReviewTap) {
                    Label("Write Review", systemImage: "square.and.pencil")
                        .font(.caption)
                        .padding(6)
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(.blue)
                        .cornerRadius(6)
                }
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(reviews) { review in
                        ReviewCard1(review: review)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top, 5)
        }
        .padding(.top)
    }
}

// MARK: - 6️⃣ Write Review Modal
struct WriteReviewView1: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var rating = 3
    @State private var comment = ""

    var onSubmit: (StudentReview) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Your Name")) {
                    TextField("e.g., Riya S.", text: $name)
                }

                Section(header: Text("Rating")) {
                    Picker("Rating", selection: $rating) {
                        ForEach(1...5, id: \.self) { i in
                            Text("\(i) Star\(i > 1 ? "s" : "")")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Comment")) {
                    TextEditor(text: $comment)
                        .frame(height: 100)
                }

                Button("Submit Review") {
                    let newReview = StudentReview(name: name, rating: rating, comment: comment)
                    onSubmit(newReview)
                    dismiss()
                }
                .disabled(name.isEmpty || comment.isEmpty)
            }
            .navigationTitle("Write Review")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

// MARK: - 7️⃣ Main View
struct IIITHyderabadView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var collegeData: CollegeModel?
    @State private var isCourseViewActive = false
    @State private var isLoading = true
    @State private var showWriteReview = false
    @State private var userReviews: [StudentReview] = []

    let sampleReviews = [
        StudentReview(name: "Anjali S.", rating: 5, comment: "The faculty is top-notch and always ready to help."),
        StudentReview(name: "Rahul M.", rating: 4, comment: "Placements are excellent."),
        StudentReview(name: "Neha R.", rating: 5, comment: "Campus life is vibrant and enriching."),
        StudentReview(name: "Aman T.", rating: 3, comment: "Needs improvement in infrastructure.")
    ]

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
                    // Logo and Title
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
                    CollegeDescriptionBlock(
                        imageURL: college.image1,
                        description: college.description1,
                        imageWidth: UIScreen.main.bounds.width - 40,
                        imageHeight: 190
                    )

                    CollegeDescriptionBlock(
                        imageURL: college.image2,
                        description: college.description2,
                        imageWidth: UIScreen.main.bounds.width - 50,
                        imageHeight: 175
                    )

                    CollegeDescriptionBlock(
                        imageURL: college.image3,
                        description: college.description3,
                        imageWidth: UIScreen.main.bounds.width - 60,
                        imageHeight: 165
                    )

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

                    // Student Reviews
                    StudentReviewSection(
                        reviews: sampleReviews + userReviews,
                        onWriteReviewTap: { showWriteReview = true }
                    )
                    .sheet(isPresented: $showWriteReview) {
                        WriteReviewView1 { newReview in
                            userReviews.append(newReview)
                        }
                    }

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
    }

    func fetchCollegeData() {
        guard let url = URL(string: ServiceAPI.iiit_hyderabadURL) else {
            print("Invalid URL")
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { isLoading = false }
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(CollegeResponse.self, from: data)
                    if decoded.success {
                        DispatchQueue.main.async {
                            self.collegeData = decoded.college
                        }
                    } else {
                        print("Failed to fetch: success false")
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
//
// MARK: - 9️⃣ Preview
struct IIITHyderabadView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            IIITHyderabadView()
        }
    }
}
