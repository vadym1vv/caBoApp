//
//  RecomendedTodayComponent.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 12.12.2025.
//

import SwiftUI

struct RecomendedTodayComponent: View {
    @ObservedObject var coreDataUserProgressVM: CoreDataUserProgressVM
    @ObservedObject var coreDataJournalVM: CoreDataJournalVM
    @StateObject private var viewModel = DailyRecomendationsMV()
    
    @AppStorage("isLightTheme") private var isLightTheme: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommended today")
                .font(FontEnum.joSaMedium20.font)
                
            HStack {
                // Item 1
                makeLink(index: viewModel.recomendationKey1)
                Spacer()
                // Item 2
                makeLink(index: viewModel.recomendationKey2)
                Spacer()
                // Item 3
                makeLink(index: viewModel.recomendationKey3)
            }
        }
        .onAppear {
            viewModel.updateRecomendationsByDate()
        }
        .foregroundColor(isLightTheme ? ColorEnum.col181818.color : ColorEnum.colFFFFFF.color)
    }
    
    
    // Helper to safely get index and create link
    @ViewBuilder
    private func makeLink(index: Int) -> some View {
        if GlobalConstant.journayCollections.indices.contains(index) {
            let item = GlobalConstant.journayCollections[index]
            
            CategoryNavigationLink(category: item, coreDataUserProgressVM: coreDataUserProgressVM, coreDataJournalVM: coreDataJournalVM) { _ in
                // We don't need the concrete model for the cell, just the category
                RecommendationCell(category: item)
            }
        }
    }
}

@ViewBuilder
func recommendationCell(for category: any CategoryProtocol) -> some View {
    VStack(alignment: .leading) {
        Image(category.image)
            .resizable()
            .scaledToFill()
            .frame(width: 110, height: 110)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        Text(category.title)
            .font(FontEnum.joSaSemibold16.font)
            .multilineTextAlignment(.leading)
            .lineLimit(2)
    }
}


struct RecomendedTodayComponent_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            RecomendedTodayComponent(coreDataUserProgressVM: CoreDataUserProgressVM(), coreDataJournalVM: CoreDataJournalVM())
                .padding()
        }
    }
}


struct CategoryNavigationLink<Label: View>: View {
    let category: any CategoryProtocol
    @ObservedObject var coreDataUserProgressVM: CoreDataUserProgressVM
    @ObservedObject var coreDataJournalVM: CoreDataJournalVM
    @ViewBuilder let label: (Any) -> Label
    
    var body: some View {
        Group {
            if let cocktail = resolveCocktail() {
                NavigationLink {
                    SingleCocktailView(coreDataUserProgressVM: coreDataUserProgressVM, coreDataJournalVM: coreDataJournalVM,cocktailModel: cocktail)
                    //                        .environmentObject(coreDataVM)
                } label: {
                    label(cocktail)
                }
            } else if let lesson = resolveCulture() {
                NavigationLink {
                    SingleCultureLessonView(coreDataUserProgressVM: coreDataUserProgressVM, coreDataJournalVM: coreDataJournalVM, cultureModel: lesson)
                    //                        .environmentObject(coreDataVM)
                } label: {
                    label(lesson)
                }
            } else if let place = resolvePlace() {
                NavigationLink {
                    SinglePlaceView(coreDataUserProgressVM: coreDataUserProgressVM, coreDataJournalVM: coreDataJournalVM, placeModel: place)
                    //                        .environmentObject(coreDataVM)
                } label: {
                    label(place)
                }
            } else if let home = resolveHomeSession() {
                NavigationLink {
                    SingleHomeSessionView(coreDataUserProgressVM: coreDataUserProgressVM, coreDataJournalVM: coreDataJournalVM, homeSessionModel: home)
                    //                        .environmentObject(coreDataVM)
                } label: {
                    label(home)
                }
            } else {
                // If no match found, render nothing or a placeholder
                EmptyView()
            }
        }
    }
    
    private func resolveCocktail() -> CocktailModel? {
        if let model = category as? CocktailModel { return model }
        return GlobalConstant.cocktailsModels.first(where: matches)
    }
    
    private func resolveCulture() -> CultureModel? {
        if let model = category as? CultureModel { return model }
        return GlobalConstant.cultureLessons.first(where: matches)
    }
    
    private func resolvePlace() -> PlacesModel? {
        if let model = category as? PlacesModel { return model }
        return GlobalConstant.placesModels.first(where: matches)
    }
    
    private func resolveHomeSession() -> HomeSessionModel? {
        if let model = category as? HomeSessionModel { return model }
        return GlobalConstant.homeSessionsModels.first(where: matches)
    }
    
    private func matches(_ item: any CategoryProtocol) -> Bool {
        return item.title == category.title && item.image == category.image
    }
}


struct RecommendationCell: View {
    let category: any CategoryProtocol
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(category.image)
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 110)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text(category.title)
                .font(FontEnum.joSaSemibold16.font)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
        }
    }
}
