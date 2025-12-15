//
//  SingleCocktailView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

struct SingleCocktailView: View {
    
    let cocktailModel: CocktailModel
    
    var body: some View {
        Text(cocktailModel.title)
    }
}

struct SingleCocktailView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCocktailView(cocktailModel: GlobalConstant.cocktailsModels[0])
    }
}
