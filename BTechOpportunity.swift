import SwiftUI

// MARK: - Model
struct BTechOpportunity: Identifiable, Decodable {
    let id: String
    let title: String
    let description: String
}

// MARK: - View
struct BTechOpportunitiesView: View {
    @Environment(\.dismiss) var dismiss
    @State private var opportunities: [BTechOpportunity] = []
    @State private var isLoading = true

    let titleColors: [Color] = [
        Color(hex: "#E63946"), Color(hex: "#1D3557"), Color(hex: "#2A9D8F"),
        Color(hex: "#F4A261"), Color(hex: "#264653"), Color(hex: "#E76F51"),
        Color(hex: "#6A994E"), Color(hex: "#9C89B8"), Color(hex: "#F72585"),
        Color(hex: "#3A0CA3")
    ]

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
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
                        Text("Technical Career Opportunities for B.Tech Graduates:")
                            .font(.system(size: 25, weight: .bold))
                            .padding(.top, 5)

                        ForEach(Array(opportunities.enumerated()), id: \.1.id) { index, item in
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\(index + 1). \(item.title)")
                                    .font(.headline)
                                    .foregroundColor(titleColors[index % titleColors.count])
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.8)

                                Text(item.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .lineLimit(3)
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

    private func fetchOpportunities() {
        guard let url = URL(string: ServiceAPI.btech_opportunitiesURL) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let decoded = try JSONDecoder().decode([BTechOpportunity].self, from: data)
                        self.opportunities = decoded
                    } catch {
                        print("Decoding error:", error)
                    }
                } else if let error = error {
                    print("Network error:", error)
                }

                self.isLoading = false
            }
        }.resume()
    }
}

// MARK: - Color Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xff) / 255
        let g = Double((int >> 8) & 0xff) / 255
        let b = Double(int & 0xff) / 255
        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - Preview
struct BTechOpportunitiesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BTechOpportunitiesView()
        }
    }
}
