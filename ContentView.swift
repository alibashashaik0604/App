import SwiftUI

struct ContentView: View {
    @State private var showLogin = false

    var body: some View {
        VStack {
            Button("Go to Login") {
                showLogin = true
            }
        }
        .fullScreenCover(isPresented: $showLogin) {
            LoginView()
        }
    }
}
