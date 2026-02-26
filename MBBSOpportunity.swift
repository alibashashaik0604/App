import SwiftUI

// MARK: - Data Model
struct MBBSOpportunity: Identifiable, Decodable {
    let id: String
    let opportunity: String
    let description: String
}

// MARK: - Main View
struct MBBSOpportunitiesView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isLoading = true
    @State private var opportunities: [MBBSOpportunity] = []
    @State private var showError = false

    let titleColors: [Color] = [
        .red, .blue, .green, .orange, .indigo,
        .pink, .purple, .teal, .brown, .cyan
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .imageScale(.large)
                        .padding()
                }
                Spacer()
            }
            .background(Color.white)
            .shadow(color: .gray.opacity(0.2), radius: 4, y: 2)

            // Content
            if isLoading {
                Spacer()
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                Spacer()
            } else if showError {
                Spacer()
                Text("Failed to load data. Please try again.")
                    .foregroundColor(.red)
                Spacer()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Career Opportunities for MBBS Graduates")
                            .font(.title2.bold())
                            .padding(.top, 20)

                        ForEach(Array(opportunities.enumerated()), id: \.1.id) { index, item in
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\(index + 1). \(item.opportunity)")
                                    .font(.headline)
                                    .foregroundColor(titleColors[index % titleColors.count])

                                Text(item.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
                        }
                    }
                    .padding()
                }
            }
        }
        .background(Color.white.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .onAppear {
            fetchOpportunities()
        }
    }

    // MARK: - Data Fetching
    func fetchOpportunities() {
        guard let url = URL(string: ServiceAPI.mbbs_opportunitiesURL) else {
            isLoading = false
            showError = true
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let decoded = try JSONDecoder().decode([MBBSOpportunity].self, from: data)
                        opportunities = decoded
                        showError = false
                    } catch {
                        print("Decoding error: \(error)")
                        showError = true
                    }
                } else {
                    print("Network error: \(error?.localizedDescription ?? "Unknown error")")
                    showError = true
                }
                isLoading = false
            }
        }.resume()
    }
}

// MARK: - Preview
struct MBBSOpportunitiesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MBBSOpportunitiesView()
        }
    }
}
