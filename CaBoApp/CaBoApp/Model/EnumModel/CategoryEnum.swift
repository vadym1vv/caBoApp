//
//  CategoryEnum.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

enum CategoryEnum: String, CaseIterable, Identifiable {
    var id: Self {self}
    case coctails = "Cocktails", cultureLessons = "Culture lessons", places = "Places", homeSessions = "Home sessions"
    
    var iconButton: String {
        switch self {
        case .coctails:
            return IconEnum.cocktailsButton.icon
        case .cultureLessons:
            return IconEnum.cultureLessonsButton.icon
        case .places:
            return IconEnum.placeButton.icon
        case .homeSessions:
            return IconEnum.homeSessionsButton.icon
        }
    }
    
    var shortDescription: String {
        switch self {
        case .coctails:
            return "Cocktails"
        case .cultureLessons:
            return "Culture"
        case .places:
            return "Places"
        case .homeSessions:
            return "Sessions"
        }
    }
    
    @ViewBuilder
    var categoryView: some View {
        switch self {
        case .coctails:
            CocktailsView()
        case .cultureLessons:
            CultureLessonsView()
        case .places:
            PlacesView()
        case .homeSessions:
            HomeSessionsView()
        }
    }
}
