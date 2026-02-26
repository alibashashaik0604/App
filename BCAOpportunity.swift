import SwiftUI

// MARK: - Model
struct BCAOpportunity: Identifiable, Codable {
    let id: String
    let opportunity: String
    let description: String
}

// MARK: - View
struct BCAOpportunitiesView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isLoading = true
    @State private var opportunities: [BCAOpportunity] = []

    let titleColors: [Color] = [
        colorFromHex("#E63946"), colorFromHex("#1D3557"), colorFromHex("#2A9D8F"),
        colorFromHex("#F4A261"), colorFromHex("#264653"), colorFromHex("#E76F51"),
        colorFromHex("#6A994E"), colorFromHex("#9C89B8"), colorFromHex("#F72585"),
        colorFromHex("#3A0CA3")
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Custom Header
            HStack {
                Button(action: { dismiss() }) {
                    Image("image321") // Make sure this image is in Assets.xcassets
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding()
                }
                Spacer()
            }
            .background(Color.white)
            .shadow(color: .gray.opacity(0.2), radius: 4, y: 2)

            // Main Content
            if isLoading {
                Spacer()
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                Spacer()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Technical Career Opportunities for BCA Graduates:")
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
            fetchOpportunities()
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Fetch from PHP API
    func fetchOpportunities() {
        guard let url = URL(string: ServiceAPI.bca_opportunitiesURL) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
            }

            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode([BCAOpportunity].self, from: data)
                    DispatchQueue.main.async {
                        self.opportunities = decoded
                    }
                } catch {
                    print("Decoding error:", error)
                }
            } else if let error = error {
                print("Network error:", error)
            }
        }.resume()
    }
}

// MARK: - Hex Color Helper
func colorFromHex(_ hex: String) -> Color {
    var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

    var rgb: UInt64 = 0
    Scanner(string: hexSanitized).scanHexInt64(&rgb)

    let red = Double((rgb & 0xFF0000) >> 16) / 255
    let green = Double((rgb & 0x00FF00) >> 8) / 255
    let blue = Double(rgb & 0x0000FF) / 255

    return Color(red: red, green: green, blue: blue)
}

// MARK: - Preview
struct BCAOpportunitiesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BCAOpportunitiesView()
        }
    }
}
