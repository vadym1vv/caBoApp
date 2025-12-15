//
//  PlacesView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

struct PlacesView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    private let placesModel: [PlacesModel] = GlobalConstant.placesModels
    
    var body: some View {
        VStack {
            TopBarNavigationComponent(
                leadingView:
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {HStack {
                        Image(IconEnum.backBtn.icon)
                        Text("Places")
                            .font(FontEnum.joSaBold24.font)
                            .foregroundColor(ColorEnum.col181818.color)
                    }
                    },
                centerView:
                    EmptyView(),
                trailingView:
                    EmptyView())
            ScrollView {
                VStack {
                    LazyVGrid(columns: columns) {
                        ForEach(placesModel) { placeModel in
                            NavigationLink {
                              SinglePlaceView(placeModel: placeModel)
                            } label: {
                                DoubleRowCardComponent(itemName: placeModel.title, itemDescription: placeModel.facts, itemImg: placeModel.image)
                            }
                            
                        }
                    }
                }
                .padding(.horizontal)
            }
            
        }
        .padding(.top, getSafeArea().top)
        .background(LinearGradientEnum.mainScreenBg.linearGradientColors)
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlacesView()
                .environmentObject(CoreDataUserProgressVM())
        }
    }
}
