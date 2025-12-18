import SwiftUI

struct SingleCocktailView: View {
    
    @ObservedObject var coreDataUserProgressVM: CoreDataUserProgressVM
    @ObservedObject var coreDataJournalVM: CoreDataJournalVM
    
    
    @AppStorage("isLightTheme") private var isLightTheme: Bool = true
    
    @State private var isItemFavorite: Bool = false
    let cocktailModel: CocktailModel

    var ingredientList: [String] {
        return cocktailModel.ingredients.split(separator: "\n").map { String($0).trimmingCharacters(in: .whitespaces) }
    }
    
    var body: some View {
        VStack {
            ScrollView {

                SingleIconActionCategoryComponent(isItemFavorite: $isItemFavorite, imgStr: cocktailModel.image, title: cocktailModel.title, bottomLeadingComponent: HStack {
                    RectangleWrapperComponent(component: Text("Cocktail"))
                    RectangleWrapperComponent(component: HStack {
                        cocktailModel.dificulty.difficultyStars
                        Text(cocktailModel.dificulty.rawValue.capitalized)
                    })
                    
                    RectangleWrapperComponent(component: Text(cocktailModel.modeEnum.rawValue))
                }) {
                    coreDataUserProgressVM.updateFavoriteItem(itemName: cocktailModel.title, categoryEnum: CategoryEnum.coctails.rawValue, toggleFavorite: true)
                }
                
                VStack {
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 13)
                            .foregroundColor(ColorEnum.colFF5D4D.color)
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(IconEnum.cocktailListImage.icon)
                                    Text("Ingredients")
                                        .font(FontEnum.joSaItalic20.font)
                                }
                                ForEach(ingredientList, id: \.self) { ingredient in
                                    HStack {
                                        Image(IconEnum.ingredientIcon.icon)
                                        Text(ingredient)
                                            .font(FontEnum.joSaRegular16.font)
                                    }
                                }
                            }
                            Spacer()
                        }
                        .padding()
                        .background(ColorEnum.colFFC8AF.color)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(1)
                    }
                    .foregroundColor(ColorEnum.col181818.color)
                    ItemDetailsCardComponent(icon: IconEnum.componentUnitOrigin, title: "Origin", bodyText: cocktailModel.origin, background: .colFFC8AF, borderColor: .colFF5D4D, iconForegroundColor: .colFF6F61)
                    ItemDetailsCardComponent(icon: IconEnum.componentUnitStory, title: "Story", bodyText: cocktailModel.story, background: .colFFC8AF, borderColor: .colFF5D4D, iconForegroundColor: .colFF6F61)
                    ItemDetailsCardComponent(icon: IconEnum.componentUnitFacts, title: "Facts", bodyText: cocktailModel.facts, background: .colFFC8AF, borderColor: .colFF5D4D, iconForegroundColor: .colFF6F61)
                    
                    
                }
                .padding(.horizontal)
            }
        }
        .background(isLightTheme ? LinearGradientEnum.mainScreenBg.linearGradientColors : LinearGradientEnum.darkBackgorund.linearGradientColors)
        .onAppear(perform: {
            isItemFavorite = coreDataUserProgressVM.items.contains(where: { $0.isFavorite && $0.itemName == cocktailModel.title })
            coreDataJournalVM.registerNewJournalEntity(itemTitle: cocktailModel.title, itemCategory: CategoryEnum.coctails.rawValue)
        })
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct SingleCocktailView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCocktailView(coreDataUserProgressVM: CoreDataUserProgressVM(), coreDataJournalVM: CoreDataJournalVM(), cocktailModel: GlobalConstant.cocktailsModels[0])
            .environmentObject(CoreDataUserProgressVM())
    }
}
