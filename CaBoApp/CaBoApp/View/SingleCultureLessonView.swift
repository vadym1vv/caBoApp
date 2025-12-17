//
//  SingleCultureLessonView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

struct SingleCultureLessonView: View {
    
    @EnvironmentObject private var coreDataUserProgressVM: CoreDataUserProgressVM
    
    @State private var isItemFavorite: Bool = false
    
    let cultureModel: CultureModel
    
    var body: some View {
        VStack {
            ScrollView {

                SingleIconActionCategoryComponent(
                    isItemFavorite: $isItemFavorite, imgStr: cultureModel.image,
                    title: cultureModel.title,
                    bottomLeadingComponent: HStack {
                        Text("Cocktail")
                    }) {
                        coreDataUserProgressVM.updateFavoriteItem(itemName: cultureModel.title, categoryEnum: CategoryEnum.cultureLessons.rawValue, toggleFavorite: true)
                    }
                
                VStack {
                    ItemDetailsCardComponent(icon: IconEnum.componentUnitOrigin, title: "Origin", bodyText: cultureModel.origin, background: .colC4E9E1, borderColor: .col008080, iconForegroundColor: .col20B2AA)
                    ItemDetailsCardComponent(icon: IconEnum.componentUnitOrigin, title: "Story", bodyText: cultureModel.story, background: .colC4E9E1, borderColor: .col008080, iconForegroundColor: .col20B2AA)
                    ItemDetailsCardComponent(icon: IconEnum.componentUnitOrigin, title: "Facts", bodyText: cultureModel.facts, background: .colC4E9E1, borderColor: .col008080, iconForegroundColor: .col20B2AA)
                    
                    
                }
                .padding(.horizontal)
            }
        }
        .background(LinearGradientEnum.greenSingleItemBackground.linearGradientColors)
        .onAppear(perform: {
            isItemFavorite = coreDataUserProgressVM.items.contains(where: { $0.isFavorite && $0.itemName == cultureModel.title })
        })
        .navigationBarHidden(true)
        .ignoresSafeArea()
        
    }
}

struct SingleCultureLessonView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCultureLessonView(cultureModel: GlobalConstant.cultureLessons[0])
    }
}
