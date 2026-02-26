import SwiftUI

struct WelcomeScreen: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer(minLength: 40)

                Image("image") // Ensure this exists in Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)

                // Login Button
                NavigationLink(destination: WelcomeScreen1()
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

                // Sign Up Button
                NavigationLink(destination: SignUpView()
                    .navigationBarBackButtonHidden(true)) {
                        Text("Sign up")
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

            }
            .padding()
            .background(Color.white)
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    WelcomeScreen()
}
