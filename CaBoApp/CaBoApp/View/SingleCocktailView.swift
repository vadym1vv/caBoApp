//
//  SingleCocktailView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

struct SingleCocktailView: View {
    
    let coctailModel: CocktailModel
    
    var body: some View {
        Text(coctailModel.title)
    }
}

struct SingleCocktailView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCocktailView(coctailModel: GlobalConstant.cocktailsModels[0])
    }
}
