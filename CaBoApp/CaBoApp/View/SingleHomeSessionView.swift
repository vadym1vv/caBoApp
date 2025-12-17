//
//  SingleHomeSessionView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

struct SingleHomeSessionView: View {
    
    @EnvironmentObject private var coreDataUserProgressVM: CoreDataUserProgressVM
    
    let homeSessionModel: HomeSessionModel
    
    @State private var isItemFavorite: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                SingleIconActionCategoryComponent(
                    isItemFavorite: $isItemFavorite, imgStr: homeSessionModel.image,
                    title: homeSessionModel.title,
                    bottomLeadingComponent: HStack {
                        Text("Cocktail")
                    }) {
                        coreDataUserProgressVM.updateFavoriteItem(itemName: homeSessionModel.title, categoryEnum: CategoryEnum.homeSessions.rawValue, toggleFavorite: true)
                    }
                
                VStack {
                    ItemDetailsCardComponent(icon: .culturePrepare, title: "Prepare", bodyText: homeSessionModel.prepare, background: .colEDE7FA, borderColor: .col7443FF, iconForegroundColor: .col926EF8)
                    ItemDetailsCardComponent(icon: .cultureMix, title: "Mix", bodyText: homeSessionModel.mix, background: .colEDE7FA, borderColor: .col7443FF, iconForegroundColor: .col926EF8)
                    ItemDetailsCardComponent(icon: .cultureListen, title: "Listen", bodyText: homeSessionModel.listen, background: .colEDE7FA, borderColor: .col7443FF, iconForegroundColor: .col926EF8)
                    ItemDetailsCardComponent(icon: .cultureReflect, title: "Reflect", bodyText: homeSessionModel.reflect, background: .colEDE7FA, borderColor: .col7443FF, iconForegroundColor: .col926EF8)
                }
                .padding(.horizontal)
            }
        }
        .background(LinearGradientEnum.purpleSingleItemBackground.linearGradientColors)
        .onAppear(perform: {
            isItemFavorite = coreDataUserProgressVM.items.contains(where: { $0.isFavorite && $0.itemName == homeSessionModel.title })
        })
        .navigationBarHidden(true)
        .ignoresSafeArea()
        
    }
}

struct SingleHomeSessionView_Previews: PreviewProvider {
    static var previews: some View {
        SingleHomeSessionView(homeSessionModel: GlobalConstant.homeSessionsModels[0])
    }
}
