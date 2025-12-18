//
//  SinglePlaceView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

struct SinglePlaceView: View {
    
    @ObservedObject var coreDataUserProgressVM: CoreDataUserProgressVM
    @ObservedObject var coreDataJournalVM: CoreDataJournalVM
    
    @AppStorage("isLightTheme") private var isLightTheme: Bool = true
    
    @State private var isItemFavorite: Bool = false
    
    let placeModel: PlacesModel
    
    var body: some View {
        VStack {
            ScrollView {

                SingleIconActionCategoryComponent(
                    isItemFavorite: $isItemFavorite, imgStr: placeModel.image,
                    title: placeModel.title,
                    bottomLeadingComponent: HStack {
                        RectangleWrapperComponent(component: Text("Places"))
                        RectangleWrapperComponent(component: Text(placeModel.modeEnum.rawValue.capitalized))
                    }) {
                        coreDataUserProgressVM.updateFavoriteItem(itemName: placeModel.title, categoryEnum: CategoryEnum.places.rawValue, toggleFavorite: true)
                    }
                
                VStack {
                    ItemDetailsCardComponent(icon: IconEnum.componentUnitOrigin, title: "Origin", bodyText: placeModel.origin, background: .colFFC8AF, borderColor: .colFF5D4D, iconForegroundColor: .colFF6F61)
                    ItemDetailsCardComponent(icon: IconEnum.componentUnitOrigin, title: "Story", bodyText: placeModel.story, background: .colFFC8AF, borderColor: .colFF5D4D, iconForegroundColor: .colFF6F61)
                    ItemDetailsCardComponent(icon: IconEnum.componentUnitOrigin, title: "Facts", bodyText: placeModel.facts, background: .colFFC8AF, borderColor: .colFF5D4D, iconForegroundColor: .colFF6F61)
                    
                    
                }
                .padding(.horizontal)
            }
        }
        .background(isLightTheme ? LinearGradientEnum.mainScreenBg.linearGradientColors : LinearGradientEnum.darkBackgorund.linearGradientColors)
        .onAppear(perform: {
            isItemFavorite = coreDataUserProgressVM.items.contains(where: { $0.isFavorite && $0.itemName == placeModel.title })
            coreDataJournalVM.registerNewJournalEntity(itemTitle: placeModel.title, itemCategory: CategoryEnum.places.rawValue)
        })
        .navigationBarHidden(true)
        .ignoresSafeArea()

    }
}

struct SinglePlaceView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePlaceView(coreDataUserProgressVM: CoreDataUserProgressVM(), coreDataJournalVM: CoreDataJournalVM(), placeModel: GlobalConstant.placesModels[0])
    }
}
