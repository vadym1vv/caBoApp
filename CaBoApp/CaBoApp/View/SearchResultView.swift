//
//  SearchResultView.swift
//  CaBoApp
//
//  Created by Vadym Vasylaki on 16.12.2025.
//

import SwiftUI

struct SearchResultView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject var coreDataUserProgressVM: CoreDataUserProgressVM
    
    var searchResults: [any CategoryProtocol]
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        VStack {
            TopBarNavigationComponent(
                leadingView:
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(IconEnum.backBtn.icon)
                        }
                        Text("Search results")
                            .font(FontEnum.joSaBold24.font)
                    },
                centerView:
                    EmptyView(),
                trailingView:
                    EmptyView())
            if (!searchResults.isEmpty) {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(searchResults, id: \.id) { searchResult in
                            recommendationView(category: searchResult, coreDataUserProgressVM: coreDataUserProgressVM)
                        }
                    }
                }
            } else {
                Image(IconEnum.searchResultsIcon.icon)
                Text("Nothing here yet.")
                Text("Try another category or remove some filters.")
            }
        }
        .font(FontEnum.joSaMedium18.font)
        .foregroundColor(ColorEnum.col181818.color)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradientEnum.mainScreenBg.linearGradientColors)
        .navigationBarHidden(true)
    }
}

#Preview {
    
    let dummyCocktail = GlobalConstant.cocktailsModels.first!
    let dummySession = GlobalConstant.homeSessionsModels.first!
    let dummyCulture = GlobalConstant.cultureLessons.first!
    
    NavigationView {
        SearchResultView(coreDataUserProgressVM: CoreDataUserProgressVM(), searchResults: [dummyCocktail, dummySession, dummyCulture])
           
    }
    
}
