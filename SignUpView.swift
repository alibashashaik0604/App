//
//  SignUpView.swift
//  collegehunts
//
//  Created by AD-LAB on 10/06/25.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isRegistered = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 20) {
                    // Back Button
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image("image321") // Add to Assets
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                        .padding(.leading, 20)
                        Spacer()
                    }
                    .padding(.top, 50)

                    // Logo
                    Image("image001") // Add to Assets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .padding(.top, -100)

                    // Email
                    VStack(alignment: .leading) {
                        Text("Email Address")
                            .foregroundColor(.black)
                        TextField("Enter your email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(25)
                    }
                    .padding(.horizontal)

                    // Password
                    VStack(alignment: .leading) {
                        Text("Create Password")
                            .foregroundColor(.black)
                        SecureField("Enter your password", text: $password)
                            .padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(25)
                    }
                    .padding(.horizontal)

                    // Confirm Password
                    VStack(alignment: .leading) {
                        Text("Confirm Password")
                            .foregroundColor(.black)
                        SecureField("Re-enter your password", text: $confirmPassword)
                            .padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(25)
                    }
                    .padding(.horizontal)

                    // Sign Up Button
                    Button(action: {
                        handleSignUp()
                    }) {
                        Text("SIGN UP")
                            .fontWeight(.bold)
                            .foregroundColor(Color.blue)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.blue, lineWidth: 2))
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                    Spacer()

                    // Hidden NavigationLink to LoginView
                    NavigationLink(
                        destination: LoginView(),
                        isActive: $isRegistered,
                        label: {
                            EmptyView()
                        })
                        .hidden()
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Sign Up"), message: Text(alertMessage), dismissButton: .default(Text("OK"), action: {
                    if alertMessage == "User registered successfully." {
                        isRegistered = true
                    }
                }))
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    func handleSignUp() {
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            alertMessage = "All fields are required."
            showAlert = true
            return
        }

        guard password == confirmPassword else {
            alertMessage = "Passwords don't match."
            showAlert = true
            return
        }

        guard let url = URL(string: ServiceAPI.signupURL) else {
            alertMessage = "Invalid server URL."
            showAlert = true
            return
        }

        let parameters: [String: String] = [
            "email": email,
            "password": password,
            "confirmPassword": confirmPassword
        ]

        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            alertMessage = "Failed to encode signup data."
            showAlert = true
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    alertMessage = "Network error: \(error.localizedDescription)"
                    showAlert = true
                    return
                }

                guard let data = data,
                      let result = try? JSONDecoder().decode(ServerResponse.self, from: data) else {
                    alertMessage = "Invalid server response."
                    showAlert = true
                    return
                }

                alertMessage = result.message
                showAlert = true
            }
        }.resume()
    }
}

// MARK: - Struct for backend response
struct ServerResponse: Decodable {
    let message: String
}

#Preview {
    SignUpView()
}
