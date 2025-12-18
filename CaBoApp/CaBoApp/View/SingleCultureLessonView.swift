//
//  SingleCultureLessonView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

struct SingleCultureLessonView: View {
    
    @ObservedObject var coreDataUserProgressVM: CoreDataUserProgressVM
    @ObservedObject var coreDataJournalVM: CoreDataJournalVM
    
    @AppStorage("isLightTheme") private var isLightTheme: Bool = true
    
    @State private var isItemFavorite: Bool = false
    
    let cultureModel: CultureModel
    
    var body: some View {
        VStack {
            ScrollView {

                SingleIconActionCategoryComponent(
                    isItemFavorite: $isItemFavorite, imgStr: cultureModel.image,
                    title: cultureModel.title,
                    bottomLeadingComponent: HStack {
                        RectangleWrapperComponent(component: Text("Culture lessons"))
                        RectangleWrapperComponent(component: Text(cultureModel.modeEnum.rawValue.capitalized))
                    }) {
                        coreDataUserProgressVM.updateFavoriteItem(itemName: cultureModel.title, categoryEnum: CategoryEnum.cultureLessons.rawValue, toggleFavorite: true)
                    }
                    .padding(.top, getSafeArea().top - 12)
                
                VStack {
                    ItemDetailsCardComponent(icon: IconEnum.componentUnitOrigin, title: "Origin", bodyText: cultureModel.origin, background: .colC4E9E1, borderColor: .col008080, iconForegroundColor: .col20B2AA)
                    ItemDetailsCardComponent(icon: IconEnum.componentUnitOrigin, title: "Story", bodyText: cultureModel.story, background: .colC4E9E1, borderColor: .col008080, iconForegroundColor: .col20B2AA)
                    ItemDetailsCardComponent(icon: IconEnum.componentUnitOrigin, title: "Facts", bodyText: cultureModel.facts, background: .colC4E9E1, borderColor: .col008080, iconForegroundColor: .col20B2AA)
                    
                    
                }
                .padding(.horizontal)
                .padding(.top, getSafeArea().top)
            }
        }
        .background(isLightTheme ? LinearGradientEnum.mainScreenBg.linearGradientColors : LinearGradientEnum.darkBackgorund.linearGradientColors)
        .onAppear(perform: {
            isItemFavorite = coreDataUserProgressVM.items.contains(where: { $0.isFavorite && $0.itemName == cultureModel.title })
            coreDataJournalVM.registerNewJournalEntity(itemTitle: cultureModel.title, itemCategory: CategoryEnum.cultureLessons.rawValue)
        })
        .navigationBarHidden(true)
        .ignoresSafeArea()
        
    }
}

struct SingleCultureLessonView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCultureLessonView(coreDataUserProgressVM: CoreDataUserProgressVM(), coreDataJournalVM: CoreDataJournalVM(), cultureModel: GlobalConstant.cultureLessons[0])
    }
}
