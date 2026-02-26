import SwiftUI

struct StudentInterest: View {
    @State private var selectedCourse = ""
    @State private var selectedLocation = ""
    @State private var isMenuOpen = false
    @State private var isHelpOpen = false
    @State private var isAboutOpen = false
    @State private var isCareerOpen = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showLogoutConfirm = false
    @State private var showWelcomeScreen = false
    @State private var navigate = false
    @State private var menuScale: CGFloat = 0.8
    @State private var menuOpacity: Double = 0
    @State private var showAIChat = false  // New state for AI Chat

    private let courses = [
        "B.Tech", "B.Sc", "BCA", "B.Com", "BBA", "BA", "MBBS", "B.Ed", "B.Des", "B.Pharm"
    ]
    private let locations = ["Andhrapradesh", "Telangana", "Karnataka", "Tamilnadu"]

    var body: some View {
        ZStack {
            mainView
                .blur(radius: isMenuOpen || isHelpOpen || isAboutOpen || isCareerOpen ? 4 : 0)
                .disabled(isMenuOpen || isHelpOpen || isAboutOpen || isCareerOpen)

            if isMenuOpen {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture { closeMenu() }

                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color.white.opacity(0.2), lineWidth: 4)
                    .padding(8)
                    .background(
                        sideMenu
                            .scaleEffect(menuScale)
                            .opacity(menuOpacity)
                            .onAppear {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                    menuScale = 1.0
                                    menuOpacity = 1.0
                                }
                            }
                    )
                    .transition(.scale)
                    .frame(width: UIScreen.main.bounds.width * 0.75)
                    .cornerRadius(20)
            }

            if isHelpOpen || isAboutOpen || isCareerOpen {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isHelpOpen = false
                            isAboutOpen = false
                            isCareerOpen = false
                        }
                    }
            }

            if isHelpOpen {
                ModalContainer(
                    icon: "questionmark.circle",
                    title: "Help & Support",
                    content: """
                  Need assistance? We're here to help you every step of the way.

                  📞 Call us: +91 939 143 3753  
                  📧 Email: support@collegehunt.com  
                  🌐 Visit: www.collegehunt.com/help

                  Support Hours:  
                  Mon - Fri: 9 AM to 6 PM  
                  Sat: 10 AM to 2 PM

                  Whether it's login issues, course queries, or application guidance, don't hesitate to reach out!
                  """
                ) { isHelpOpen = false }
            }

            if isAboutOpen {
                ModalContainer(
                    icon: "info.circle",
                    title: "About Us",
                    content: """
                  CollegeHunt is your trusted companion in navigating India's vast higher education landscape.

                  🎯 Our Mission:  
                  To simplify college discovery and empower students to make informed career choices.

                  💡 What We Offer:  
                  - State-wise college listings  
                  - Course-specific details  
                  - Entrance exam info  
                  - Career opportunity insights

                  Trusted by thousands of students across Andhra Pradesh, Telangana, Tamil Nadu, and Karnataka.
                  """
                ) { isAboutOpen = false }
            }

            if isCareerOpen {
                ModalContainer(
                    icon: "briefcase.fill",
                    title: "Career Guidance",
                    content: """
                    🎓 Confused about what to do after 12th?

                    We’re here to guide you with tailored career paths based on your stream and interests.

                    🔍 Explore:  
                    - Engineering, Medicine, Management, Arts, and more  
                    - Career opportunities after each course  
                    - Skill-based suggestions  
                    - Top institutions in your state

                    🧭 Let CollegeHunt be your compass to the future you deserve!
                    """
                ) { isCareerOpen = false }
            }

            NavigationLink(destination: destinationView(), isActive: $navigate) {
                EmptyView()
            }

            // ✅ AI Chat Button (Floating)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showAIChat.toggle()
                    }) {
                        Image(systemName: "message.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding(.trailing, 24)
                    .padding(.bottom, 30)
                    .sheet(isPresented: $showAIChat) {
                        AIChatbotView() // Placeholder screen for AI chat
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .confirmationDialog("Are you sure you want to logout?", isPresented: $showLogoutConfirm, titleVisibility: .visible) {
            Button("Logout", role: .destructive, action: performLogout)
            Button("Cancel", role: .cancel) {}
        }
        .fullScreenCover(isPresented: $showWelcomeScreen) {
            WelcomeScreen()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    var mainView: some View {
        VStack(spacing: 15) {
            HStack {
                Button(action: {
                    withAnimation {
                        isMenuOpen = true
                        menuScale = 0.8
                        menuOpacity = 0
                    }
                }) {
                    Image(systemName: "line.3.horizontal")
                        .resizable()
                        .frame(width: 25, height: 20)
                        .padding(12)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding(.leading, 20)
                Spacer()
            }

            Image("image001")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)

            Text("STUDENT INTERESTED IN")
                .font(.headline)
                .bold()

            VStack(alignment: .leading) {
                Text("     Select Department").bold()
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(.systemGray5))
                        .frame(height: 50)
                    Picker("Select Department", selection: $selectedCourse) {
                        Text("Select Department").tag("")
                        ForEach(courses, id: \.self) { Text($0) }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.horizontal)
                    .foregroundColor(selectedCourse.isEmpty ? .gray : .primary)
                }
            }
            .padding(.horizontal)

            VStack(alignment: .leading) {
                Text("    Select Location").bold()
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(.systemGray5))
                        .frame(height: 50)
                    Picker("Select Location", selection: $selectedLocation) {
                        Text("Select Location").tag("")
                        ForEach(locations, id: \.self) { Text($0) }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.horizontal)
                    .foregroundColor(selectedLocation.isEmpty ? .gray : .primary)
                }
            }
            .padding(.horizontal)

            Button(action: viewCollege) {
                Text("VIEW COLLEGE")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 55).stroke(Color.blue, lineWidth: 2))
            }
            .padding(.horizontal)

            Spacer()
        }
    }

    var sideMenu: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Image(systemName: "graduationcap.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26, height: 26)
                    .foregroundColor(.white)
                Text("CollegeHunt")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .padding(.top, 60)
            .padding(.horizontal)

            Divider().padding(.horizontal, 16)

            VStack(spacing: 16) {
                MenuButton(label: "Help & Support", icon: "questionmark.circle") {
                    closeMenu()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation { isHelpOpen = true }
                    }
                }
                MenuButton(label: "Career Guidance", icon: "briefcase.fill") {
                    closeMenu()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation { isCareerOpen = true }
                    }
                }
                MenuButton(label: "About Us", icon: "info.circle") {
                    closeMenu()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation { isAboutOpen = true }
                    }
                }
                MenuButton(label: "Logout", icon: "arrowshape.turn.up.left", isDestructive: true) {
                    closeMenu()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        showLogoutConfirm = true
                    }
                }
            }

            Spacer()
        }
        .padding(.top, 40)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(BlurView(style: .systemMaterialDark).opacity(0.95))
        .cornerRadius(20)
    }

    func viewCollege() {
        if selectedCourse.isEmpty {
            alertMessage = "Please select a course."
            showAlert = true
        } else if selectedLocation.isEmpty {
            alertMessage = "Please select a location."
            showAlert = true
        } else {
            navigate = true
        }
    }

    func destinationView() -> some View {
        switch selectedLocation {
        case "Andhrapradesh": return AnyView(AndhraPradeshView())
        case "Telangana": return AnyView(Telangana())
        case "Karnataka": return AnyView(Karnataka())
        case "Tamilnadu": return AnyView(Tamilnadu())
        default: return AnyView(Text("Invalid location selected."))
        }
    }

    func performLogout() {
        showWelcomeScreen = true
    }

    func closeMenu() {
        withAnimation(.spring()) {
            menuScale = 0.8
            menuOpacity = 0
            isMenuOpen = false
        }
    }
}

struct MenuButton: View {
    var label: String
    var icon: String
    var isDestructive: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                Text(label)
                    .font(.system(size: 17, weight: .medium))
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(isDestructive ? Color.red.opacity(0.1) : Color.blue.opacity(0.1))
            .foregroundColor(isDestructive ? .red : .blue)
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

struct ModalContainer: View {
    var icon: String
    var title: String
    var content: String
    var onClose: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .font(.title2)
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Button(action: { withAnimation { onClose() } }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }

            ScrollView {
                Text(content)
                    .font(.body)
                    .foregroundColor(.primary)
                    .padding(.top, 4)
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width * 0.8, height: 420)
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(radius: 10)
        .transition(.scale)
    }
}

// 🔵 Placeholder AI Chat View
struct AIChatView: View {
    var body: some View {
        VStack {
            Text("AI Chat Assistant")
                .font(.title2)
                .bold()
                .padding()
            Spacer()
            Text("This feature is coming soon...")
                .foregroundColor(.gray)
            Spacer()
        }
    }
}

struct StudentInterestView_Previews: PreviewProvider {
    static var previews: some View {
        StudentInterest()
    }
}
