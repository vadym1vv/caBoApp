//
//  MainScreenView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 10.12.2025.
//

import SwiftUI

struct MainScreenView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack {
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(colorScheme == .light ? LinearGradientEnum.mainScreenBg.linearGradientColors : LinearGradientEnum.darkBackgorund.linearGradientColors)
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
