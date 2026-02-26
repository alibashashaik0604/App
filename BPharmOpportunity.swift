import SwiftUI

// MARK: - Model
struct BPharmOpportunity: Identifiable, Decodable {
    let id: String
    let title: String
    let description: String
}

// MARK: - View
struct BPharmOpportunitiesView: View {
    @Environment(\.dismiss) var dismiss
    @State private var opportunities: [BPharmOpportunity] = []
    @State private var isLoading = true
    @State private var showError = false

    let titleColors: [Color] = [
        .red, .blue, .green, .orange, .indigo,
        .pink, .purple, .teal, .brown, .cyan
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: { dismiss() }) {
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
                Text("Failed to load data.")
                    .foregroundColor(.red)
                Spacer()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Career Opportunities for B.Pharm Graduates")
                            .font(.system(size: 25, weight: .bold))
                            .padding(.top, 5)

                        ForEach(Array(opportunities.enumerated()), id: \.1.id) { index, item in
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\(index + 1). \(item.title)")
                                    .font(.headline)
                                    .foregroundColor(titleColors[index % titleColors.count])
                                    .lineLimit(1)

                                Text(item.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .lineLimit(4)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
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
        .onAppear { fetchOpportunities() }
    }

    // MARK: - Fetch Data
    func fetchOpportunities() {
        guard let url = URL(string: ServiceAPI.bpharm_opportunitiesURL) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                isLoading = false
                if let data = data {
                    do {
                        let decoded = try JSONDecoder().decode([BPharmOpportunity].self, from: data)
                        self.opportunities = decoded
                    } catch {
                        self.showError = true
                    }
                } else {
                    self.showError = true
                }
            }
        }.resume()
    }
}

// MARK: - Preview
struct BPharmOpportunitiesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BPharmOpportunitiesView()
        }
    }
}
