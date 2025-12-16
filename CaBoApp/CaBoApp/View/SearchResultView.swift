//
//  SearchResultView.swift
//  CaBoApp
//
//  Created by Vadym Vasylaki on 16.12.2025.
//

import SwiftUI

struct SearchResultView: View {
    
    var searchResults: [any CategoryProtocol]
    
    var body: some View {
        VStack {
            ForEach(searchResults, id: \.id) { searchResult in
                Text(searchResult.title)
            }
        }
    }
}

#Preview {
    
    let dummyCocktail = GlobalConstant.cocktailsModels.first!
    let dummySession = GlobalConstant.homeSessionsModels.first!
    let dummyCulture = GlobalConstant.cultureLessons.first!
    
    SearchResultView(searchResults: [dummyCocktail, dummySession, dummyCulture])
    
}
