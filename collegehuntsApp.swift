
import SwiftUI

@main
struct CollegeHuntsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                WelcomeScreen ()
                    .navigationBarBackButtonHidden(true)
                    .toolbar(.hidden, for: .navigationBar)
            }
        }
    }
}
