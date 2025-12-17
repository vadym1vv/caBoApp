//
//  FavoritesView.swift
//  CaBoApp
//
//  Created by Vadym Vasylaki on 15.12.2025.
//

import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject private var coreDataUserProgressVM: CoreDataUserProgressVM
    
    @State private var selectedCategory: [CategoryEnum] = CategoryEnum.allCases
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var sortedItems: [ItemEntity] {
        let selectedCategoryDescription: [String] = selectedCategory.map({$0.rawValue})
        return coreDataUserProgressVM.items.filter { itemEntity in
            return itemEntity.isFavorite && selectedCategoryDescription.contains(itemEntity.itemType ?? "")
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
        HStack {
            Text("Favorites")
                   .font(FontEnum.joSaBold24.font)
            Spacer()
        }
            HStack {
                Button {
                    selectedCategory = []
                    selectedCategory = CategoryEnum.allCases
                } label: {
                    Text("All")
//                        .frame(height: 70)
                        .frame(maxHeight: .infinity)
                        .padding(.horizontal)
                        .background(selectedCategory == CategoryEnum.allCases ? ColorEnum.colFFC8AF.color : ColorEnum.colFFFFFF.color)
                    
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                ForEach(CategoryEnum.allCases) { category in
                    Button {
                        if (selectedCategory == CategoryEnum.allCases) {
                            selectedCategory = []
                        }
                        if (selectedCategory.contains(category)) {
                            selectedCategory.removeAll(where: {$0 == category})
                        } else {
                            selectedCategory.append(category)
                        }
                    } label: {
                        Text(category.shortDescription)
//                            .frame(height: 70)
                            .frame(maxHeight: .infinity)
                            .padding(.horizontal, 8)
                            .background(selectedCategory.contains(where: {$0 == category}) && selectedCategory != CategoryEnum.allCases ? ColorEnum.colFFC8AF.color : ColorEnum.colFFFFFF.color)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.height / 25)
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(sortedItems, id: \.self) { sortedItem in
                            DoubleRowCardComponent(itemName: <#T##String#>, itemDescription: <#T##String#>, itemImg: <#T##String#>, categoryEnum: <#T##CategoryEnum#>)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .font(FontEnum.joSaMedium14.font)
    }
}

#Preview {
    VStack {
        FavoritesView()
        Spacer()
    }
    .background(LinearGradientEnum.mainScreenBg.linearGradientColors)
}
