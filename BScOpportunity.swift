import SwiftUI

// MARK: - Data Model
struct BScOpportunity: Identifiable, Decodable {
    let id: String
    let title: String
    let description: String
}

// MARK: - Main View
struct BScOpportunitiesView: View {
    @Environment(\.dismiss) var dismiss
    @State private var opportunities: [BScOpportunity] = []
    @State private var isLoading = true

    let titleColors = [
        Color(hex: "#E63946"), Color(hex: "#1D3557"), Color(hex: "#2A9D8F"),
        Color(hex: "#F4A261"), Color(hex: "#264653"), Color(hex: "#E76F51"),
        Color(hex: "#6A994E"), Color(hex: "#9C89B8"), Color(hex: "#F72585"),
        Color(hex: "#3A0CA3")
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Header with back button (restored original style)
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit() // Restore this
                        .frame(width: 24, height: 24)
                        .foregroundColor(.black)
                        .padding()
                }
                Spacer()
            }
            .background(Color.white)
            .shadow(color: .gray.opacity(0.2), radius: 4, y: 2)

            if isLoading {
                Spacer()
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                Spacer()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Technical Career Opportunities for B.Sc Graduates:")
                            .font(.system(size: 25, weight: .bold))
                            .padding(.top, 5)

                        ForEach(Array(opportunities.enumerated()), id: \.1.id) { index, item in
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\(index + 1). \(item.title)")
                                    .font(.headline)
                                    .foregroundColor(titleColors[index % titleColors.count])
                                Text(item.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 100)
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

    func fetchOpportunities() {
        guard let url = URL(string: ServiceAPI.bsc_opportunitiesURL) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode([BScOpportunity].self, from: data)
                    DispatchQueue.main.async {
                        self.opportunities = decoded
                        self.isLoading = false
                    }
                } catch {
                    print("Decoding error:", error)
                }
            } else {
                print("Fetch error:", error?.localizedDescription ?? "Unknown error")
            }
        }.resume()
    }
}

// MARK: - Preview
struct BScOpportunitiesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BScOpportunitiesView()
        }
    }
}
