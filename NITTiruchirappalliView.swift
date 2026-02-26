import SwiftUI

// MARK: - Main View
struct NITTiruchirappalliView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var college: NITTCollegeData?
    @State private var isLoading = true
    @State private var errorMessage: String?
    @State private var isCourseViewActive = false
    @State private var showReviewSheet = false
    @State private var reviews: [Review] = sampleReviews.shuffled()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // Back Button
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                            .shadow(radius: 1)
                    }
                    Spacer()
                }
                .padding(.horizontal)

                if isLoading {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity)
                        .padding()
                } else if let college = college {

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
                        .cornerRadius(10)
                        .shadow(radius: 3)

                        Text(college.name)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)

                        Spacer()
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    // Description Blocks
                    CollegeBlock(imageURL: college.image1, description: college.description1, imageWidth: UIScreen.main.bounds.width - 40, imageHeight: 190)
                    CollegeBlock(imageURL: college.image2, description: college.description2, imageWidth: UIScreen.main.bounds.width - 50, imageHeight: 180)
                    CollegeBlock(imageURL: college.image3, description: college.description3, imageWidth: UIScreen.main.bounds.width - 60, imageHeight: 170)

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
                                .cornerRadius(12)
                                .shadow(radius: 2)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)

                } else if let error = errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .padding(.top)
            .padding(.bottom, 40)
        }
        .background(Color.white)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            fetchCollegeData()
            reviews = sampleReviews.shuffled() // <--- Shuffle reviews here
        }
        .sheet(isPresented: $showReviewSheet) {
            WriteReviewView { newReview in
                reviews.insert(newReview, at: 0)
            }
        }
    }

    func fetchCollegeData() {
        guard let url = URL(string: ServiceAPI.nittURL) else {
            self.errorMessage = "Invalid URL"
            self.isLoading = false
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false

                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }

                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(NITTCollegeResponse.self, from: data)
                    self.college = decoded.college
                } catch {
                    self.errorMessage = "Decoding error: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

// MARK: - Models
struct Review: Identifiable {
    let id = UUID()
    let author: String
    let rating: Int
    let comment: String
}

struct NITTCollegeResponse: Codable {
    let success: Bool
    let college: NITTCollegeData
}

struct NITTCollegeData: Codable {
    let name: String
    let image_logo: String
    let image1: String
    let image2: String
    let image3: String
    let description1: String
    let description2: String
    let description3: String
}

// MARK: - Sample Data
let sampleReviews = [
    Review(author: "Anjali S.", rating: 5, comment: "The faculty at this college truly sets it apart. Every professor I’ve interacted with has been incredibly knowledgeable, approachable, and deeply passionate about their subject. They’re always available during office hours and even go out of their way to help students after class."),
    
    Review(author: "Rahul M.", rating: 4, comment: "One of the strongest aspects of this institution is the placement support. We have regular training sessions, mock interviews, and resume workshops. The placement cell works hard to bring in top-tier companies and startups from various sectors."),
    
    Review(author: "Divya K.", rating: 5, comment: "The peer group here is simply phenomenal. You’re constantly surrounded by intelligent, motivated, and creative minds. From hackathons to startup ideas, the tech culture thrives with energy and collaboration."),
    
    Review(author: "Siddharth R.", rating: 4, comment: "The labs on campus are impressive – well-maintained, equipped with the latest technology, and open for extended hours."),
    
    Review(author: "Meghana T.", rating: 5, comment: "Academic support here goes far beyond just lectures. From tutoring sessions and additional doubt-clearing classes to peer mentoring and study groups, the college ensures you’re never left behind."),
    
    Review(author: "Karthik J.", rating: 3, comment: "The course curriculum is thorough and well-structured, covering everything from fundamentals to advanced topics. However, I found the workload to be quite intense, especially during exam seasons.")
]

// MARK: - Review Carousel
struct ReviewCarouselView: View {
    let reviews: [Review]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(reviews) { review in
                    ReviewCard(review: review)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct ReviewCard: View {
    let review: Review

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(review.author)
                .font(.headline)
            HStack(spacing: 2) {
                ForEach(0..<5) { i in
                    Image(systemName: i < review.rating ? "star.fill" : "star")
                        .foregroundColor(i < review.rating ? .yellow : .gray)
                }
            }
            Text("“\(review.comment)”")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)
        }
        .padding()
        .frame(width: 280, height: 160)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(14)
        .shadow(radius: 4)
    }
}

// MARK: - Write Review Form
struct WriteReviewView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var comment = ""
    @State private var rating = 4
    var onSubmit: (Review) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Your Details")) {
                    TextField("Your Name", text: $name)
                }

                Section(header: Text("Your Review")) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Rating")
                            Spacer()
                            HStack {
                                ForEach(1..<6) { i in
                                    Image(systemName: i <= rating ? "star.fill" : "star")
                                        .foregroundColor(i <= rating ? .yellow : .gray)
                                        .onTapGesture {
                                            rating = i
                                        }
                                }
                            }
                        }
                        TextEditor(text: $comment)
                            .frame(height: 100)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                    }
                }

                Button("Submit Review") {
                    let newReview = Review(author: name.isEmpty ? "Anonymous" : name, rating: rating, comment: comment)
                    onSubmit(newReview)
                    dismiss()
                }
                .disabled(comment.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .navigationTitle("Write a Review")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Reusable College Block
struct CollegeBlock: View {
    let imageURL: String
    let description: String
    let imageWidth: CGFloat
    let imageHeight: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageWidth, height: imageHeight)
                    .clipped()
                    .cornerRadius(16)
                    .shadow(radius: 4)
                    .padding(.horizontal, 20)
            } placeholder: {
                Color.gray.opacity(0.3)
                    .frame(width: imageWidth, height: imageHeight)
                    .cornerRadius(16)
                    .padding(.horizontal, 20)
            }

            Text(description)
                .font(.body)
                .foregroundColor(.primary)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 2)
                )
                .padding(.horizontal)
        }
    }
}

// MARK: - Preview
struct NITTiruchirappalliView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NITTiruchirappalliView()
        }
    }
}
