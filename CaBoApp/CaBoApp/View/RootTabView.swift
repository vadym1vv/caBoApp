//
//  TabView.swift
//  CaBoApp
//
//  Created by Vadym Vasylaki on 16.12.2025.
//

import SwiftUI

struct RootTabView: View {
    @Environment(\.colorScheme) private var colorScheme
    
//    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var coreDataUserProgressVM: CoreDataUserProgressVM = CoreDataUserProgressVM()
    
    @State private var tabComponentEnum: TabComponentEnum = .home
    
    var body: some View {
        VStack {
            tabComponentEnum.tabView
                .environmentObject(coreDataUserProgressVM)
                .padding(.top, getSafeArea().top)
            TabBarNavigationComponent(selectedTabComponentEnum: $tabComponentEnum)
                .padding(.horizontal)
                .padding(.bottom, getSafeArea().bottom)
        }
        
        .frame(height: UIScreen.main.bounds.height)
        
        .background(colorScheme == .light ? LinearGradientEnum.mainScreenBg.linearGradientColors : LinearGradientEnum.darkBackgorund.linearGradientColors)
        
        .navigationBarHidden(true)
        .ignoresSafeArea()

    }
}

#Preview {
    RootTabView()
}
