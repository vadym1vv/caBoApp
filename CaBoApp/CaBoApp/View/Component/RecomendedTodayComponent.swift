//
//  RecomendedTodayComponent.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 12.12.2025.
//

import SwiftUI

struct RecomendedTodayComponent: View {
    @ObservedObject var coreDataUserProgressVM: CoreDataUserProgressVM
    @StateObject private var viewModel = DailyRecomendationsMV()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommended today")
                .font(FontEnum.joSaMedium20.font)
                .foregroundColor(ColorEnum.col181818.color)
            HStack {
                recommendationView(category: GlobalConstant.journayCollections[viewModel.recomendationKey1], showDescription: false, coreDataUserProgressVM: coreDataUserProgressVM)
                Spacer()
                recommendationView(category: GlobalConstant.journayCollections[viewModel.recomendationKey2], showDescription: false, coreDataUserProgressVM: coreDataUserProgressVM)
                Spacer()
                recommendationView(category: GlobalConstant.journayCollections[viewModel.recomendationKey3], showDescription: false, coreDataUserProgressVM: coreDataUserProgressVM)
            }
        }
        .onAppear {
            viewModel.updateRecomendationsByDate()
        }
    }
}
@ViewBuilder
func recommendationView(category: any CategoryProtocol, showDescription: Bool,  coreDataUserProgressVM: CoreDataUserProgressVM) -> some View {
    

    if let cocktail = GlobalConstant.cocktailsModels.first(where: {
        $0.title == category.title && $0.image == category.image
    }) {
        NavigationLink {
            SingleCocktailView(cocktailModel: cocktail)
                .environmentObject(coreDataUserProgressVM)
        } label: {
            recommendationCell(for: category)
        }

    } else if let lesson = GlobalConstant.cultureLessons.first(where: {
        $0.title == category.title && $0.image == category.image
    }) {
        NavigationLink {
            SingleCultureLessonView(cultureModel: lesson)
                .environmentObject(coreDataUserProgressVM)
        } label: {
            recommendationCell(for: category)
        }

    } else if let place = GlobalConstant.placesModels.first(where: {
        $0.title == category.title && $0.image == category.image
    }) {
        NavigationLink {
            SinglePlaceView(placeModel: place)
                .environmentObject(coreDataUserProgressVM)
        } label: {
            recommendationCell(for: category)
        }

    } else if let home = GlobalConstant.homeSessionsModels.first(where: {
        $0.title == category.title && $0.image == category.image
    }) {
        NavigationLink {
            SingleHomeSessionView(homeSessionModel: home)
                .environmentObject(coreDataUserProgressVM)
        } label: {
            recommendationCell(for: category)
        }
    } else {
        EmptyView()
    }
}



@ViewBuilder
func favoritesDoubleRowCardView(category: any CategoryProtocol, showDescription: Bool,  coreDataUserProgressVM: CoreDataUserProgressVM) -> some View {
    

    if let cocktail = GlobalConstant.cocktailsModels.first(where: {
        $0.title == category.title && $0.image == category.image
    }) {
        NavigationLink {
            SingleCocktailView(cocktailModel: cocktail)
                .environmentObject(coreDataUserProgressVM)
        } label: {
            DoubleRowCardComponent(itemName: cocktail.title, itemDescription: cocktail.facts, itemImg: cocktail.image, categoryEnum: .coctails)
        }

    } else if let lesson = GlobalConstant.cultureLessons.first(where: {
        $0.title == category.title && $0.image == category.image
    }) {
        NavigationLink {
            SingleCultureLessonView(cultureModel: lesson)
                .environmentObject(coreDataUserProgressVM)
        } label: {
            DoubleRowCardComponent(itemName: lesson.title, itemDescription: lesson.facts, itemImg: lesson.image, categoryEnum: .cultureLessons)
        }

    } else if let place = GlobalConstant.placesModels.first(where: {
        $0.title == category.title && $0.image == category.image
    }) {
        NavigationLink {
            SinglePlaceView(placeModel: place)
                .environmentObject(coreDataUserProgressVM)
        } label: {
            DoubleRowCardComponent(itemName: place.title, itemDescription: place.facts, itemImg: place.image, categoryEnum: .places)
        }

    } else if let home = GlobalConstant.homeSessionsModels.first(where: {
        $0.title == category.title && $0.image == category.image
    }) {
        NavigationLink {
            SingleHomeSessionView(homeSessionModel: home)
                .environmentObject(coreDataUserProgressVM)
        } label: {
            DoubleRowCardComponent(itemName: home.title, itemDescription: home.timeForSession.rawValue, itemImg: home.image, categoryEnum: .homeSessions)
        }
    } else {
        EmptyView()
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
            .foregroundColor(ColorEnum.col181818.color)
            .font(FontEnum.joSaSemibold16.font)
            .multilineTextAlignment(.leading)
            .lineLimit(2)
    }
}


struct RecomendedTodayComponent_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            RecomendedTodayComponent(coreDataUserProgressVM: CoreDataUserProgressVM())
                .padding()
        }
    }
}
