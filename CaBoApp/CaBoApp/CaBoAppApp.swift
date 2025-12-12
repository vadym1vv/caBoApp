//
//  CaBoAppApp.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 10.12.2025.
//

import SwiftUI

@main
struct CaBoAppApp: App {
    
    init() {
        UserDefaults.standard.register(defaults: [
            "isFirstOpening": true,
            "lastRecomdationDateDay" : Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        ])
    }
    
    var body: some Scene {
        WindowGroup {
            PreloaderView()
            
        }
    }
}
