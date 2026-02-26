import SwiftUI

// MARK: - Course Model
struct Course: Identifiable, Codable {
    let id: Int
    let name: String         // Short form (e.g., B.Tech)
    let fullName: String     // Full form (e.g., Bachelor of Technology)
    let duration: String
    let eligibility: String
    let fees: String
    let screen: String       // Used to route to respective screen
}

// MARK: - Main Course View
struct CourseView: View {
    @Environment(\.dismiss) var dismiss
    @State private var expandedCourseID: Int? = nil
    @State private var courses: [Course] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack(spacing: 12) {
                Button(action: { dismiss() }) {
                    Image("image321")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(8)
                        .background(Color.gray.opacity(0.15))
                        .clipShape(Circle())
                }
                Text("List of Courses")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)

            if isLoading {
                ProgressView("Loading courses...")
                    .padding(.top, 40)
                Spacer()
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(courses) { course in
                            VStack(alignment: .leading, spacing: 12) {
                                // Tappable Header
                                Button(action: {
                                    withAnimation {
                                        expandedCourseID = (expandedCourseID == course.id) ? nil : course.id
                                    }
                                }) {
                                    HStack {
                                        Text(course.name)
                                            .font(.headline)
                                            .foregroundColor(.blue)
                                        Spacer()
                                        Image(systemName: expandedCourseID == course.id ? "chevron.up" : "chevron.down")
                                            .foregroundColor(.gray)
                                    }
                                }

                                // Expanded Section
                                if expandedCourseID == course.id {
                                    Divider()

                                    Text(course.fullName)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .padding(.bottom, 6)

                                    Group {
                                        Label(course.duration, systemImage: "clock")
                                        Label(course.eligibility, systemImage: "person.fill.checkmark")
                                        Label(course.fees, systemImage: "indianrupeesign.circle.fill")
                                    }
                                    .font(.subheadline)
                                    .foregroundColor(.black)

                                    NavigationLink(destination: destinationView(for: course.screen)) {
                                        Text("Explore Career Opportunities")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 10)
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                    .padding(.top, 8)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: .gray.opacity(0.15), radius: 4, x: 0, y: 2)
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top, 16)
                }
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarHidden(true)
        .onAppear {
            fetchCourses()
        }
    }

    // MARK: - Destination View Mapper
    @ViewBuilder
    private func destinationView(for screen: String) -> some View {
        switch screen {
        case "BTechCareer": BTechOpportunitiesView()
        case "BScCareer": BScOpportunitiesView()
        case "BCACareer": BCAOpportunitiesView()
        case "BComCareer": BComOpportunitiesView()
        case "BBACareer": BBAOpportunitiesView()
        case "BACareer": BAOpportunitiesView()
        case "MBBSCareer": MBBSOpportunitiesView()
        case "BEDCareer": BEdOpportunitiesView()
        case "BDesCareer": BDesOpportunitiesView()
        case "BPharmCareer": BPharmOpportunitiesView()
        default:
            Text("Career Opportunities Coming Soon")
        }
    }

    // MARK: - Fetch Courses from Backend
    private func fetchCourses() {
        guard let url = URL(string: ServiceAPI.coursesURL) else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false

                if let error = error {
                    errorMessage = "Error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    errorMessage = "No data received"
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode([Course].self, from: data)
                    self.courses = decoded
                } catch {
                    errorMessage = "Failed to decode JSON: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CourseView()
    }
}
