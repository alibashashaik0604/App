import SwiftUI

struct WelcomeScreen1: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Custom Back Button using image123
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image("image123") // Ensure "image123" is in Assets
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .padding(.leading)
                    Spacer()
                }
                .padding(.top)

                Spacer(minLength: 10)

                Image("image") // Ensure this exists in Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)

                // Login Button
                NavigationLink(destination: LoginView()
                    .navigationBarBackButtonHidden(true)) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    }
                    .cornerRadius(25)
                    .padding(.horizontal)

                // Admin Button
                NavigationLink(destination: AdminLoginView()
                    .navigationBarBackButtonHidden(true)) {
                        Text("Admin")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    }
                    .cornerRadius(25)
                    .padding(.horizontal)

                Image("image2") // Ensure this exists in Assets
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)

                Spacer()
            }
            .padding()
            .background(Color.white)
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    WelcomeScreen1()
}
