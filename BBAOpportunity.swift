import SwiftUI

// MARK: - Model
struct BBAOpportunity: Identifiable, Decodable {
    let id: String
    let opportunity: String
    let description: String
}

// MARK: - View
struct BBAOpportunitiesView: View {
    @Environment(\.dismiss) var dismiss
    @State private var opportunities: [BBAOpportunity] = []
    @State private var isLoading = true

    let titleColors: [Color] = [
        Color.red, Color.blue, Color.green, Color.orange, Color.indigo,
        Color.pink, Color.purple, Color.teal, Color.brown, Color.cyan
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Header with back button
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image("image321")
                        .resizable()
                        .frame(width: 24, height: 24)
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
                        Text("Career Opportunities for BBA Graduates")
                            .font(.system(size: 25, weight: .bold))
                            .padding(.top, 5)

                        ForEach(Array(opportunities.enumerated()), id: \.1.id) { index, item in
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\(index + 1). \(item.opportunity)")
                                    .font(.headline)
                                    .foregroundColor(titleColors[index % titleColors.count])
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.8)

                                Text(item.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .lineLimit(4)
                                    .minimumScaleFactor(0.8)
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
        .onAppear {
            fetchOpportunities()
        }
    }

    // MARK: - API Call
    func fetchOpportunities() {
        guard let url = URL(string: ServiceAPI.bba_opportunitiesURL) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
            }

            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode([BBAOpportunity].self, from: data)
                    DispatchQueue.main.async {
                        self.opportunities = decoded
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            } else if let error = error {
                print("HTTP request error: \(error)")
            }
        }.resume()
    }
}

// MARK: - Preview
struct BBAOpportunitiesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BBAOpportunitiesView()
        }
    }
}
