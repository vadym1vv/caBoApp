//
//  MainScreenView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 10.12.2025.
//

import SwiftUI

struct MainScreenView: View {
    
    
    
    @EnvironmentObject private var coreDataUserProgressVM: CoreDataUserProgressVM
    @EnvironmentObject private var coreDataJournalVM: CoreDataJournalVM
    @EnvironmentObject private var coreDataSearchEntityVM: CoreDataSearchEntityVM
    
    @AppStorage("isLightTheme") private var isLightTheme: Bool = true
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: GlobalConstant.viewComponentSpacing) {
                HStack {
                    Text("Hola, Max")
                        .font(FontEnum.joSaBold24.font)
                    Spacer()
                    NavigationLink {
                        SettingsView()
                            .environmentObject(coreDataUserProgressVM)
                            .environmentObject(coreDataJournalVM)
                            .environmentObject(coreDataSearchEntityVM)
                        
                    } label: {
                        Image(IconEnum.settings.icon)
                    }
                }
                
                Text("Tonight’s Cuba at a glance")
                    .font(FontEnum.daScMedium30.font)
                    .padding(.top, -20)
                JourneyComponent(coreDataUserProgressVM: coreDataUserProgressVM, coreDataJournalVM: coreDataJournalVM)
                Text("Quick actions")
                    .font(FontEnum.joSaMedium20.font)
                HStack(alignment: .top) {
                    Spacer()
                    ForEach(CategoryEnum.allCases) { category in
                        NavigationLink {
                            category.categoryView
                                .environmentObject(coreDataUserProgressVM)
                                .environmentObject(coreDataJournalVM)
                        } label: {
                            VStack {
                                Image(category.iconButton)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.height / 15, height: UIScreen.main.bounds.height / 15)
                                Text(category.rawValue.capitalized)
                                    .font(FontEnum.joSaRegular16.font)
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
                RecomendedTodayComponent(coreDataUserProgressVM: coreDataUserProgressVM, coreDataJournalVM: coreDataJournalVM)
                    .padding(.bottom, getSafeArea().bottom)
                
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
        .foregroundColor(isLightTheme ? ColorEnum.col181818.color : ColorEnum.colFFFFFF.color)
        .frame(maxWidth: .infinity, maxHeight: .infinity)

        
        .onAppear(perform: {
            UserDefaults.standard.setValue(false, forKey: "isFirstOpening")
        })
        
//        .navigationBarHidden(true)
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainScreenView()
                .environmentObject(CoreDataUserProgressVM())
                .environmentObject(CoreDataJournalVM())
                .environmentObject(CoreDataSearchEntityVM())
        }
    }
}
