
import SwiftUI

@main
struct CaBoAppApp: App {
    
    init() {
        IAPManager.shared.start()
        UserDefaults.standard.register(defaults: [
            "isFirstOpening": true,
            "isLightTheme": true,
            "lastRecomdationDateDay" : Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        ])
    }
    
    var body: some Scene {
        WindowGroup {
            PreloaderView()
        }
    }
}
