
import SwiftUI

struct SearchResultView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @AppStorage("isLightTheme") private var isLightTheme: Bool = true
    
    @ObservedObject var coreDataUserProgressVM: CoreDataUserProgressVM
    @ObservedObject var coreDataJournalVM: CoreDataJournalVM
    
    var searchResults: [any CategoryProtocol]
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
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
                            .foregroundColor(isLightTheme ? ColorEnum.col181818.color : ColorEnum.colFFFFFF.color)
                    },
                centerView:
                    EmptyView(),
                trailingView:
                    EmptyView())
            .padding(.top, getSafeArea().top)
            if (!searchResults.isEmpty) {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(searchResults, id: \.id) { item in
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
                    Image(IconEnum.searchResultsIcon.icon)
                        .padding(.vertical)
                        .padding(.top, 40)
                    Text("Nothing here yet. Try another category or remove some filters.")
                        .font(FontEnum.joSaMedium18.font)
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Reset filters")
                            .font(FontEnum.joSaBold16.font)
                            .foregroundColor(ColorEnum.colFFFFFF.color)
                            .frame(width: UIScreen.main.bounds.width / 2, height: 44)
                            .background(LinearGradientEnum.onboardingBtnBg.linearGradientColors)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                    }
                    .padding(.top)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal)
        .font(FontEnum.joSaMedium18.font)
        .foregroundColor(isLightTheme ? ColorEnum.col181818.color : ColorEnum.colFFFFFF.color)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isLightTheme ? LinearGradientEnum.mainScreenBg.linearGradientColors : LinearGradientEnum.darkBackgorund.linearGradientColors)
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

#Preview {
    
    let dummyCocktail = GlobalConstant.cocktailsModels.first!
    let dummySession = GlobalConstant.homeSessionsModels.first!
    let dummyCulture = GlobalConstant.cultureLessons.first!
    
    NavigationView {
        SearchResultView(coreDataUserProgressVM: CoreDataUserProgressVM(), coreDataJournalVM: CoreDataJournalVM(), searchResults: [])
        
    }
    
}
