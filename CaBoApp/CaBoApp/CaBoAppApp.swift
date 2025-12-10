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
        ])
    }
    
    var body: some Scene {
        WindowGroup {
            PreloaderView()
            
        }
    }
}
