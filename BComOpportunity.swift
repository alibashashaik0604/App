import SwiftUI

// MARK: - Model
struct BComOpportunity: Identifiable, Codable {
    let id: String
    let opportunity: String
    let description: String
}

// MARK: - View
struct BComOpportunitiesView: View {
    @Environment(\.dismiss) var dismiss
    @State private var opportunities: [BComOpportunity] = []
    @State private var isLoading = true
    @State private var hasError = false

    let titleColors: [Color] = [
        Color(red: 0.90, green: 0.22, blue: 0.27),
        Color(red: 0.11, green: 0.21, blue: 0.34),
        Color(red: 0.17, green: 0.62, blue: 0.56),
        Color(red: 0.96, green: 0.64, blue: 0.38),
        Color(red: 0.15, green: 0.27, blue: 0.33),
        Color(red: 0.91, green: 0.44, blue: 0.32),
        Color(red: 0.42, green: 0.60, blue: 0.31),
        Color(red: 0.61, green: 0.54, blue: 0.72),
        Color(red: 0.97, green: 0.15, blue: 0.52),
        Color(red: 0.23, green: 0.05, blue: 0.64)
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image("image321") // Replace with your asset name
                        .resizable()
                        .frame(width: 24, height: 24)
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
            } else if hasError {
                Spacer()
                Text("Failed to load data.")
                    .foregroundColor(.red)
                    .padding()
                Spacer()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Career Opportunities for B.Com Graduates:")
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
        .onAppear {
            fetchBComOpportunities()
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Networking
    func fetchBComOpportunities() {
        guard let url = URL(string: ServiceAPI.bcom_opportunitiesURL) else {
            self.hasError = true
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let decoded = try JSONDecoder().decode([BComOpportunity].self, from: data)
                        self.opportunities = decoded
                        self.isLoading = false
                    } catch {
                        print("Decoding error:", error)
                        self.hasError = true
                    }
                } else {
                    print("Fetch error:", error ?? "Unknown error")
                    self.hasError = true
                }
            }
        }.resume()
    }
}

// MARK: - Preview
struct BComOpportunitiesView_Previews: PreviewProvider {
    static var previews: some View {
        BComOpportunitiesPreviewWrapper()
    }

    struct BComOpportunitiesPreviewWrapper: View {
        @State private var dummyData: [BComOpportunity] = [
            BComOpportunity(id: "1", opportunity: "Accountant", description: "Manage financial records and audits."),
            BComOpportunity(id: "2", opportunity: "Financial Analyst", description: "Analyze company financials and market trends."),
            BComOpportunity(id: "3", opportunity: "Tax Consultant", description: "Assist clients in tax planning and filing.")
        ]

        var body: some View {
            BComOpportunitiesView(opportunities: dummyData, isLoading: false)
        }
    }
}

// MARK: - Extension for Preview
extension BComOpportunitiesView {
    init(opportunities: [BComOpportunity], isLoading: Bool) {
        self._opportunities = State(initialValue: opportunities)
        self._isLoading = State(initialValue: isLoading)
        self._hasError = State(initialValue: false)
    }
}
