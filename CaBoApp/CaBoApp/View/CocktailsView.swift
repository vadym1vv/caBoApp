//
//  Cocktails.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

struct CocktailsView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    
    
    var body: some View {
        VStack {
            TopBarNavigationComponent(
                leadingView:
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(IconEnum.backBtn.icon)
                        }
                    },
                centerView:
                    EmptyView(),
                trailingView:
                    EmptyView()
            )
            ScrollView(showsIndicators: false) {
                ForEach(GlobalConstant.cocktailsModels) { item in
                    
                }
            }
        }
    }
}

struct Cocktails_Previews: PreviewProvider {
    static var previews: some View {
        CocktailsView()
    }
}
