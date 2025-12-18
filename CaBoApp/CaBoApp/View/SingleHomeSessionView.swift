//
//  SingleHomeSessionView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

struct SingleHomeSessionView: View {
    
    @ObservedObject var coreDataUserProgressVM: CoreDataUserProgressVM
    @ObservedObject var coreDataJournalVM: CoreDataJournalVM
    
    @AppStorage("isLightTheme") private var isLightTheme: Bool = true
    
    @State private var isItemFavorite: Bool = false
    
    let homeSessionModel: HomeSessionModel
    
    var body: some View {
        VStack {
            ScrollView {
                SingleIconActionCategoryComponent(
                    isItemFavorite: $isItemFavorite, imgStr: homeSessionModel.image,
                    title: homeSessionModel.title,
                    bottomLeadingComponent: HStack {
                        RectangleWrapperComponent(component: Text("Home\nsessions"))
                            .multilineTextAlignment(.center)
                        RectangleWrapperComponent(component: HStack {
                            homeSessionModel.dificulty.difficultyStars
                            Text(homeSessionModel.dificulty.rawValue.capitalized)
                        })
                        .lineLimit(1)
                        RectangleWrapperComponent(component: Text(homeSessionModel.modeEnum.rawValue.capitalized))
                        RectangleWrapperComponent(component: HStack {
                            Image(IconEnum.timeNeededIcon.icon)
                            Text(homeSessionModel.timeForSession.rawValue)
                                .lineLimit(1)
                        })
                        
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
        .background(isLightTheme ? LinearGradientEnum.mainScreenBg.linearGradientColors : LinearGradientEnum.darkBackgorund.linearGradientColors)
        .onAppear(perform: {
            isItemFavorite = coreDataUserProgressVM.items.contains(where: { $0.isFavorite && $0.itemName == homeSessionModel.title })
            coreDataJournalVM.registerNewJournalEntity(itemTitle: homeSessionModel.title, itemCategory: CategoryEnum.homeSessions.rawValue)
        })
        .navigationBarHidden(true)
        .ignoresSafeArea()
        
    }
}

struct SingleHomeSessionView_Previews: PreviewProvider {
    static var previews: some View {
        SingleHomeSessionView(coreDataUserProgressVM: CoreDataUserProgressVM(), coreDataJournalVM: CoreDataJournalVM(), homeSessionModel: GlobalConstant.homeSessionsModels[0])
    }
}
