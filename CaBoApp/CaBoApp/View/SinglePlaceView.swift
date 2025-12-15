//
//  SinglePlaceView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

struct SinglePlaceView: View {
    
    @EnvironmentObject private var coreDataUserProgressVM: CoreDataUserProgressVM
    
    let placeModel: PlacesModel
    
    @State private var isItemFavorite: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                //                ZStack {
                //                    Image(cocktailModel.image)
                //                        .resizable()
                //                        .scaledToFill()
                //                        .frame(width: UIScreen.main.bounds.width)
                //                        .clipShape(RoundedRectangle(cornerRadius: 12))
                //
                //                    VStack {
                //                        TopBarNavigationComponent(leadingView: Button(action: {
                //
                //                        }, label: {
                //                            Image(IconEnum.backBtn.icon)
                //                        }), centerView: Text(cocktailModel.title), trailingView: Button(action: {
                //
                //                        }, label: {
                //                            Image(isFavoriteIcon)
                //                        }))
                //                        .padding(.top, getSafeArea().top)
                //                        Spacer()
                //                    }
                //
                //                    VStack {
                //                        Spacer()
                //                        HStack {
                //                            Text("Cocktail")
                //                                .padding()
                //                                .background(ColorEnum.colFFFFFF.color)
                //                            Spacer()
                //                        }
                //                    }
                //                    .padding()
                //
                //                }
                //                .frame(height: UIScreen.main.bounds.height / 2)
                
                SingleIconActionCategoryComponent(
                    isItemFavorite: $isItemFavorite, imgStr: placeModel.image,
                    title: placeModel.title,
                    bottomLeadingComponent: HStack {
                        Text("Cocktail")
                    }) {
                        coreDataUserProgressVM.updateItem(itemName: placeModel.title, toggleFavorite: true)
                    }
                
                VStack {
                    ItemDetailsCardComponent(icon: IconEnum.componentUnitOrigin, title: "Origin", bodyText: placeModel.origin, background: .colFFC8AF, borderColor: .colFF5D4D, iconForegroundColor: .colFF6F61)
                    ItemDetailsCardComponent(icon: IconEnum.componentUnitOrigin, title: "Story", bodyText: placeModel.story, background: .colFFC8AF, borderColor: .colFF5D4D, iconForegroundColor: .colFF6F61)
                    ItemDetailsCardComponent(icon: IconEnum.componentUnitOrigin, title: "Facts", bodyText: placeModel.facts, background: .colFFC8AF, borderColor: .colFF5D4D, iconForegroundColor: .colFF6F61)
                    
                    
                }
                .padding(.horizontal)
            }
        }
        .background(LinearGradientEnum.yellowSingleItemBackground.linearGradientColors)
        .onAppear(perform: {
            isItemFavorite = coreDataUserProgressVM.items.contains(where: { $0.isFavorite && $0.itemName == placeModel.title })
        })
        .navigationBarHidden(true)
        .ignoresSafeArea()

    }
}

struct SinglePlaceView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePlaceView(placeModel: GlobalConstant.placesModels[0])
    }
}
