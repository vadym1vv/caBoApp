//
//  PreloaderView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 10.12.2025.
//

import SwiftUI

struct PreloaderView: View {
    
    @State private var navigateToOnboarding: Bool = false
    @State private var navigateToMainScreen: Bool = false
    
    
    var body: some View {
        NavigationView{
            VStack {
                NavigationLink(isActive: $navigateToOnboarding) {
                    OnboardingView()
                } label: {
                    EmptyView()
                }
                NavigationLink(isActive: $navigateToMainScreen) {
                    RootTabView()
                } label: {
                    EmptyView()
                }
                Text("Preloader")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { _ in
                    if  (UserDefaults.standard.bool(forKey: "isFirstOpening")) {
                        navigateToOnboarding = true
                    } else {
                        navigateToMainScreen = true
                    }
                })
            }
        }
    }
}

struct PreloaderView_Previews: PreviewProvider {
    static var previews: some View {
        PreloaderView()
    }
}
