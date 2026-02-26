//import SwiftUI
//
//// MARK: - Review Model
//struct Review: Identifiable {
//    let id = UUID()
//    let userName: String
//    let rating: Int
//    let comment: String
//    let date: String
//}
//
//// MARK: - Main View
//struct CollegeReviewView: View {
//    var collegeName: String
//    
//    @Environment(\.dismiss) private var dismiss
//    @State private var showForm = false
//    @State private var selectedFilter: String = "All"
//    
//    @State private var reviews: [Review] = [
//        Review(userName: "Ananya Sharma", rating: 5, comment: "Top-notch faculty and campus!", date: "2025-07-21"),
//        Review(userName: "Rahul Mehta", rating: 1, comment: "Waste of time, worst hostel experience.", date: "2025-07-20"),
//        Review(userName: "Sneha Reddy", rating: 4, comment: "Good placements and events.", date: "2025-07-19"),
//        Review(userName: "Vikram Joshi", rating: 2, comment: "Outdated syllabus, not recommended.", date: "2025-07-18"),
//        Review(userName: "Priya Nair", rating: 3, comment: "Average experience overall.", date: "2025-07-17"),
//        Review(userName: "Ravi Teja", rating: 5, comment: "Amazing experience, must join!", date: "2025-07-16"),
//        Review(userName: "Deepika Rao", rating: 4, comment: "Well-maintained labs and clubs.", date: "2025-07-15"),
//        Review(userName: "Kiran Patel", rating: 2, comment: "Faculty is okay but no internships.", date: "2025-07-14"),
//        Review(userName: "Ajay Kumar", rating: 1, comment: "Bad infrastructure and zero support.", date: "2025-07-13")
//    ]
//    
//    var filteredReviews: [Review] {
//        switch selectedFilter {
//        case "Positive":
//            return reviews.filter { $0.rating >= 4 }
//        case "Negative":
//            return reviews.filter { $0.rating <= 2 }
//        case "5", "4", "3", "2", "1":
//            if let rating = Int(selectedFilter) {
//                return reviews.filter { $0.rating == rating }
//            }
//        default:
//            return reviews
//        }
//        return reviews
//    }
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                ScrollView {
//                    VStack(alignment: .leading, spacing: 12) {
//                        
//                        // MARK: - Filter Buttons
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack(spacing: 10) {
//                                ForEach(["All", "5", "4", "3", "2", "1", "Positive", "Negative"], id: \.self) { filter in
//                                    Button(action: {
//                                        selectedFilter = filter
//                                    }) {
//                                        Text(filterLabel(filter))
//                                            .padding(.horizontal, 12)
//                                            .padding(.vertical, 6)
//                                            .background(selectedFilter == filter ? Color.blue : Color.gray.opacity(0.2))
//                                            .foregroundColor(selectedFilter == filter ? .white : .primary)
//                                            .cornerRadius(20)
//                                    }
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
//                        
//                        Divider()
//                            .padding(.horizontal)
//                        
//                        Text("User Reviews")
//                            .font(.title2).bold()
//                            .padding(.horizontal)
//                        
//                        if filteredReviews.isEmpty {
//                            Text("No reviews match your filter.")
//                                .foregroundColor(.gray)
//                                .padding(.horizontal)
//                        } else {
//                            ForEach(filteredReviews) { review in
//                                ReviewCard(review: review)
//                                    .padding(.horizontal)
//                            }
//                        }
//                    }
//                    .padding(.top)
//                }
//                
//                Spacer()
//            }
//            .navigationTitle("College Reviews")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    Button(action: { dismiss() }) {
//                        Image(systemName: "chevron.left")
//                            .foregroundColor(.blue)
//                    }
//                }
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button("Write") {
//                        showForm = true
//                    }
//                }
//            }
//            .sheet(isPresented: $showForm) {
//                ReviewForm { newReview in
//                    reviews.insert(newReview, at: 0)
//                }
//            }
//        }
//    }
//    
//    func filterLabel(_ key: String) -> String {
//        switch key {
//        case "All": return "All"
//        case "Positive": return "Positive (4★+)"
//        case "Negative": return "Negative (1-2★)"
//        default: return "\(key) Star\(key == "1" ? "" : "s")"
//        }
//    }
//}
//
//// MARK: - Review Card
//struct ReviewCard: View {
//    let review: Review
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            HStack {
//                Text(review.userName)
//                    .font(.headline)
//                Spacer()
//                HStack(spacing: 2) {
//                    ForEach(0..<review.rating, id: \.self) { _ in
//                        Image(systemName: "star.fill")
//                            .foregroundColor(.yellow)
//                            .font(.caption)
//                    }
//                }
//            }
//            
//            Text(review.comment)
//                .font(.body)
//                .fixedSize(horizontal: false, vertical: true)
//            
//            Text(review.date)
//                .font(.caption)
//                .foregroundColor(.gray)
//        }
//        .padding()
//        .background(Color(UIColor.systemGray6))
//        .cornerRadius(12)
//        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
//    }
//}
//
//// MARK: - Review Form
//struct ReviewForm: View {
//    @Environment(\.dismiss) private var dismiss
//    @State private var name = ""
//    @State private var rating = 5
//    @State private var comment = ""
//    
//    var onSubmit: (_ review: Review) -> Void
//    
//    var body: some View {
//        NavigationStack {
//            Form {
//                Section(header: Text("Your Name")) {
//                    TextField("Enter your name", text: $name)
//                }
//                
//                Section(header: Text("Rating")) {
//                    Stepper("Rating: \(rating) Star\(rating == 1 ? "" : "s")", value: $rating, in: 1...5)
//                }
//                
//                Section(header: Text("Your Review")) {
//                    TextEditor(text: $comment)
//                        .frame(height: 100)
//                }
//                
//                Section {
//                    Button("Submit") {
//                        let date = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
//                        let userName = name.trimmingCharacters(in: .whitespaces).isEmpty ? "Anonymous" : name
//                        let review = Review(userName: userName, rating: rating, comment: comment, date: date)
//                        onSubmit(review)
//                        dismiss()
//                    }
//                    .disabled(comment.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
//                }
//            }
//            .navigationTitle("Write a Review")
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    Button("Cancel") { dismiss() }
//                }
//            }
//        }
//    }
//}
//
//// MARK: - Preview
//struct CollegeReviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        CollegeReviewView(collegeName: "IIT Madras")
//    }
//}
