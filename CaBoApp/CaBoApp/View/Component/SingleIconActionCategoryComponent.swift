//
//  SingleIconActionCategoryComponent.swift
//  CaBoApp
//
//  Created by Vadym Vasylaki on 15.12.2025.
//

import SwiftUI

struct SingleIconActionCategoryComponent<BottomLeadingComponent: View>: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @Binding var isItemFavorite: Bool
    
    let imgStr: String
    let title: String
//    let isFavoriteIcon: Bool
    var bottomLeadingComponent: BottomLeadingComponent
    var toggleFavoriteAction: () -> ()
    
   
    
    var body: some View {
        ZStack {
            Image(imgStr)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack {
                TopBarNavigationComponent(
                    leadingView:
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(IconEnum.backBtn.icon)
                        }),
                    centerView:
                        Text(title),
                    trailingView:
                        Button(action: {
                            isItemFavorite.toggle()
                            toggleFavoriteAction()
                        }, label: {
                            Image(isItemFavorite ? IconEnum.favIconOn.icon : IconEnum.favIconOff.icon)
                        })
                )
                .padding(.top, getSafeArea().top)
                Spacer()
            }
            
            VStack {
                Spacer()
                HStack {
                    bottomLeadingComponent
                    Spacer()
                }
            }
            .padding()
            
        }
        .frame(height: UIScreen.main.bounds.height / 2)
        
    }
}

#Preview {
    VStack {
        ScrollView {
            SingleIconActionCategoryComponent(
                isItemFavorite: .constant(false),
                imgStr: GlobalConstant.cocktailsModels[0].image,
                title: GlobalConstant.cocktailsModels[0].title,
                bottomLeadingComponent: HStack {
                    Text("Cocktail")
                    Text("Medium")
                }) {}
        }
    }
    .background(LinearGradientEnum.yellowSingleItemBackground.linearGradientColors)
}
