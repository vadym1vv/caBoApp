//
//  MainScreenView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 10.12.2025.
//

import SwiftUI

struct MainScreenView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @StateObject private var coreDataUserProgressVM: CoreDataUserProgressVM = CoreDataUserProgressVM()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Hola, Max")
                        .font(FontEnum.joSaBold24.font)
                    Spacer()
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(IconEnum.settings.icon)
                    }
                }
                Text("Tonight’s Cuba at a glance")
                    .font(FontEnum.daScMedium30.font)
                JourneyComponent()
                Text("Quick actions")
                    .font(FontEnum.joSaMedium20.font)
                HStack {
                    Spacer()
                    ForEach(CategoryEnum.allCases) { category in
                        NavigationLink {
                            category.categoryView
                                .environmentObject(coreDataUserProgressVM)
                        } label: {
                            VStack {
                                Image(category.iconButton)
                                Text(category.rawValue.capitalized)
                                    .font(FontEnum.joSaRegular16.font)
                                    .foregroundColor(ColorEnum.col181818.color)
                            }
                        }
                        .padding(5)
                    }
                    Spacer()
                }
    //            Text("Categories")
    //                .font(FontEnum.joSaMedium20.font)
    //            HStack {
    //                ForEach(CategoryEnum.allCases) { category in
    //                    NavigationLink {
    //                        category.categoryView
    //                    } label: {
    //                        Button {
    //
    //                        } label: {
    //                            Text(category.shortDescription)
    //                                .font(FontEnum.joSaMedium14.font)
    //                                .frame(height: 36)
    //                                .background(ColorEnum.colFFFFFF.color)
    //                                .foregroundColor(ColorEnum.col181818.color)
    //                        }
    //
    //                    }
    //                    .padding(5)
    //                }
    //            }
                Spacer()
                RecomendedTodayComponent()
                
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(colorScheme == .light ? LinearGradientEnum.mainScreenBg.linearGradientColors : LinearGradientEnum.darkBackgorund.linearGradientColors)
        .onAppear(perform: {
            UserDefaults.standard.setValue(false, forKey: "isFirstOpening")
        })
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainScreenView()
        }
    }
}
