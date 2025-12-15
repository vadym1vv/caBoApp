//
//  RecomendedTodayComponent.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 12.12.2025.
//

import SwiftUI

struct RecomendedTodayComponent: View {
    
    @StateObject private var viewModel = DailyRecomendationsMV()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommended today")
                .font(FontEnum.joSaMedium20.font)
                .foregroundColor(ColorEnum.col181818.color)
            HStack {
                recommendationView(for: viewModel.recomendationKey1)
                Spacer()
                recommendationView(for: viewModel.recomendationKey2)
                Spacer()
                recommendationView(for: viewModel.recomendationKey3)
            }
        }
        .onAppear {
            viewModel.updateRecomendationsByDate()
        }
    }
}
@ViewBuilder
func recommendationView(for index: Int) -> some View {
    let category = GlobalConstant.journayCollections[index]

    if let cocktail = GlobalConstant.cocktailsModels.first(where: {
        $0.title == category.title && $0.image == category.image
    }) {
        NavigationLink {
            SingleCocktailView(coctailModel: cocktail)
        } label: {
            recommendationCell(for: category)
        }

    } else if let lesson = GlobalConstant.cultureLessons.first(where: {
        $0.title == category.title && $0.image == category.image
    }) {
        NavigationLink {
            SingleCultureLessonView(cultureModel: lesson)
        } label: {
            recommendationCell(for: category)
        }

    } else if let place = GlobalConstant.placesModels.first(where: {
        $0.title == category.title && $0.image == category.image
    }) {
        NavigationLink {
            SinglePlaceView(placeModel: place)
        } label: {
            recommendationCell(for: category)
        }

    } else if let home = GlobalConstant.homeSessionsModels.first(where: {
        $0.title == category.title && $0.image == category.image
    }) {
        NavigationLink {
            SingleHomeSessionView(homeSessionModel: home)
        } label: {
            recommendationCell(for: category)
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
            RecomendedTodayComponent()
                .padding()
        }
    }
}
