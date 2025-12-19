
import SwiftUI

struct FavoritesView: View {
    
    @EnvironmentObject private var coreDataUserProgressVM: CoreDataUserProgressVM
    @EnvironmentObject private var coreDataJournalVM: CoreDataJournalVM
    
    @AppStorage("isLightTheme") private var isLightTheme: Bool = true
    
    @State private var selectedCategory: [CategoryEnum] = CategoryEnum.allCases
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var sortedItems: [any CategoryProtocol] {
        let selectedCategoryDescription: [String] = selectedCategory.map({$0.rawValue})
        let favoritesFormCoreDataToShow = coreDataUserProgressVM.items.filter { itemEntity in
            return itemEntity.isFavorite && selectedCategoryDescription.contains(itemEntity.itemType ?? "")
        }
        return GlobalConstant.journayCollections.filter { categoryProtocolItem in
            return favoritesFormCoreDataToShow.contains(where: {$0.itemName == categoryProtocolItem.title})
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
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(selectedCategory == CategoryEnum.allCases ? ColorEnum.colFFC8AF.color : ColorEnum.colFFFFFF.color)
                        .foregroundColor(ColorEnum.col181818.color)
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
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(selectedCategory.contains(where: {$0 == category}) && selectedCategory != CategoryEnum.allCases ? ColorEnum.colFFC8AF.color : ColorEnum.colFFFFFF.color)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .foregroundColor(ColorEnum.col181818.color)
                    }
                }
            }
            .font(FontEnum.joSaMedium14.font)
            .frame(height: UIScreen.main.bounds.height / 25)
            
            if (!sortedItems.isEmpty){
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns) {
                        ForEach(sortedItems, id: \.id) { item in
                            CategoryNavigationLink(category: item, coreDataUserProgressVM: coreDataUserProgressVM, coreDataJournalVM: coreDataJournalVM) { resolvedItem in
                                
                                
                                if let cocktail = resolvedItem as? CocktailModel {
                                    DoubleRowCardComponent(coreDataUserProgressVM: coreDataUserProgressVM, itemName: cocktail.title, itemDescription: cocktail.facts, itemImg: cocktail.image, categoryEnum: .coctails)
                                } else if let lesson = resolvedItem as? CultureModel {
                                    DoubleRowCardComponent(coreDataUserProgressVM: coreDataUserProgressVM, itemName: lesson.title, itemDescription: lesson.facts, itemImg: lesson.image, categoryEnum: .cultureLessons)
                                } else if let place = resolvedItem as? PlacesModel {
                                    DoubleRowCardComponent(coreDataUserProgressVM: coreDataUserProgressVM, itemName: place.title, itemDescription: place.facts, itemImg: place.image, categoryEnum: .places)
                                } else if let home = resolvedItem as? HomeSessionModel {
                                    DoubleRowCardComponent(coreDataUserProgressVM: coreDataUserProgressVM, itemName: home.title, itemDescription: home.timeForSession.rawValue, itemImg: home.image, categoryEnum: .homeSessions)
                                }
                            }
                        }
                    }
                }
            } else {
                VStack {
                    Image(IconEnum.journalFavIcon.icon)
                        .padding(.vertical)
                        .padding(.top, 40)
                    Text("There are no favorites yet. Click the star icon on any card to save it here.")
                    
                        .font(FontEnum.joSaMedium18.font)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
        }
        .foregroundColor(isLightTheme ? ColorEnum.col181818.color : ColorEnum.colFFFFFF.color)
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .font(FontEnum.joSaMedium14.font)
        .foregroundColor(ColorEnum.col181818.color)
    }
}

#Preview {
    VStack {
        FavoritesView()
            .environmentObject(CoreDataUserProgressVM())
            .environmentObject(CoreDataJournalVM())
        Spacer()
    }
    .background(LinearGradientEnum.mainScreenBg.linearGradientColors)
}
