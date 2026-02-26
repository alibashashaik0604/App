//
//  BDesOpportunitiesView.swift
//  collegehunts
//
//  Created by AD-LAB on 23/06/25.
//

import SwiftUI

// MARK: - Data Model
struct BDesOpportunity: Identifiable, Codable {
    let id: String
    let opportunity: String
    let description: String
}

// MARK: - Main View
struct BDesOpportunitiesView: View {
    @Environment(\.dismiss) var dismiss
    @State private var opportunities: [BDesOpportunity] = []
    @State private var isLoading = true

    let titleColors: [Color] = [
        .red, .blue, .green, .orange, .indigo,
        .pink, .purple, .teal, .brown, .cyan
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Header with Back Button
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

            // Main Content
            if isLoading {
                Spacer()
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                Spacer()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Career Opportunities for B.Design Graduates")
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

    // MARK: - Data Fetching Function
    func fetchOpportunities() {
        guard let url = URL(string: ServiceAPI.bdes_opportunitiesURL) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let decoded = try JSONDecoder().decode([BDesOpportunity].self, from: data)
                        self.opportunities = decoded
                        self.isLoading = false
                    } catch {
                        print("Decoding error: \(error)")
                        self.isLoading = false
                    }
                } else {
                    print("Fetch error: \(error?.localizedDescription ?? "Unknown error")")
                    self.isLoading = false
                }
            }
        }.resume()
    }
}

// MARK: - Preview
struct BDesOpportunitiesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BDesOpportunitiesView()
        }
    }
}
