import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isSuccessAlert = false
    @State private var navigateToStudentInterest = false

    var body: some View {
        NavigationStack {
            VStack {
                ZStack(alignment: .bottom) {
                    VStack(spacing: 20) {
                        // Back Button
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image("image321")
                                    .resizable()
                                    .frame(width: 24, height: 20)
                            }
                            .padding(.leading, 20)
                            Spacer()
                        }
                        .padding(.top, 50)

                        // Logo
                        Image("image001")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 300)
                            .padding(.top, -120)

                        // Email Field
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

                        // Password Field
                        VStack(alignment: .leading) {
                            Text("Password")
                                .foregroundColor(.black)

                            SecureField("Enter your password", text: $password)
                                .padding()
                                .background(Color(.systemGray5))
                                .cornerRadius(25)
                        }
                        .padding(.horizontal)

                        // Login Button
                        Button(action: handleLogin) {
                            Text("LOGIN")
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
                    }

                    // Bottom Wave
                    Image("wave")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: 150)
                        .edgesIgnoringSafeArea(.bottom)
                }
                .navigationDestination(isPresented: $isSuccessAlert) {
                    StudentInterest()
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Login"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK")) {
                        if isSuccessAlert {
                            navigateToStudentInterest = true
                        }
                    }
                )
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    // MARK: - Login Logic
    func handleLogin() {
        guard !email.isEmpty, !password.isEmpty else {
            alertMessage = "Email and password are required."
            isSuccessAlert = false
            showAlert = true
            return
        }

        guard isValidEmail(email) else {
            alertMessage = "Please enter a valid email address."
            isSuccessAlert = false
            showAlert = true
            return
        }

        guard let url = URL(string: ServiceAPI.loginURL) else {
            alertMessage = "Invalid backend URL."
            isSuccessAlert = false
            showAlert = true
            return
        }

        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters) else {
            alertMessage = "Failed to encode parameters."
            isSuccessAlert = false
            showAlert = true
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    alertMessage = "Request error: \(error.localizedDescription)"
                    isSuccessAlert = false
                    showAlert = true
                    return
                }

                guard let data = data else {
                    alertMessage = "No data received from server."
                    isSuccessAlert = false
                    showAlert = true
                    return
                }

                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let success = json["success"] as? Bool {
                        if success {
                            alertMessage = "Login Successful"
                            isSuccessAlert = true
                            showAlert = true
                        } else {
                            alertMessage = json["message"] as? String ?? "Login Failed"
                            isSuccessAlert = false
                            showAlert = true
                        }
                    } else {
                        alertMessage = "Invalid response format."
                        isSuccessAlert = false
                        showAlert = true
                    }
                } catch {
                    alertMessage = "Failed to parse response."
                    isSuccessAlert = false
                    showAlert = true
                }
            }
        }.resume()
    }

    // MARK: - Email Validation
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{1,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
}

#Preview {
    LoginView()
}
