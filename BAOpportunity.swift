import SwiftUI

// MARK: - Data Model
struct BAOpportunity: Identifiable, Codable {
    let id: String
    let opportunity: String
    let description: String
}
//
// MARK: - Main View
struct BAOpportunitiesView: View {
    @Environment(\.dismiss) var dismiss
    @State private var opportunities: [BAOpportunity] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    let titleColors: [Color] = [
        colorFromHex("#E63946"), colorFromHex("#1D3557"), colorFromHex("#2A9D8F"),
        colorFromHex("#F4A261"), colorFromHex("#264653"), colorFromHex("#E76F51"),
        colorFromHex("#6A994E"), colorFromHex("#9C89B8"), colorFromHex("#F72585"),
        colorFromHex("#3A0CA3")
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Header with back button
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image("image321") // Replace with your back icon name
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding()
                }
                Spacer()
            }
            .background(Color.white)
            .shadow(color: .gray.opacity(0.2), radius: 4, y: 2)

            // Body Content
            if isLoading {
                Spacer()
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                Spacer()
            } else if let error = errorMessage {
                Spacer()
                Text(error)
                    .foregroundColor(.red)
                    .padding()
                Spacer()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Career Opportunities for BA Graduates:")
                            .font(.system(size: 25, weight: .bold))
                            .padding(.top, 5)

                        ForEach(Array(opportunities.enumerated()), id: \.1.id) { index, item in
                            VStack(alignment: .leading, spacing: 6) {
                                Text("\(index + 1). \(item.opportunity)")
                                    .font(.system(size: 19, weight: .bold))
                                    .foregroundColor(titleColors[index % titleColors.count])

                                Text(item.description)
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
        }
        .background(Color.white.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .onAppear {
            fetchOpportunities()
        }
    }

    // MARK: - Network Fetch Function
    private func fetchOpportunities() {
        guard let url = URL(string: ServiceAPI.ba_opportunitiesURL) else {
            self.errorMessage = "Invalid backend URL."
            self.isLoading = false
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false

                if let error = error {
                    self.errorMessage = "Failed to fetch data: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    self.errorMessage = "No data received from server."
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    let decoded = try decoder.decode([BAOpportunity].self, from: data)
                    self.opportunities = decoded
                } catch {
                    self.errorMessage = "Decoding error: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

// MARK: - Preview
struct BAOpportunitiesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BAOpportunitiesView()
        }
    }
}
