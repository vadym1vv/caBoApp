//
//  GlobalConstant.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import Foundation

struct GlobalConstant {
    private static let rawData = JourneyDataLoader.loadData()
    
    static let cocktailsModels: [CocktailModel] = rawData.cocktails
    static let cultureLessons: [CultureModel] = rawData.culture
    static let placesModels: [PlacesModel] = rawData.places
    static let homeSessionsModels: [HomeSessionModel] = rawData.homeSessions
    
    static let journayCollections: [any CategoryProtocol] =
    cocktailsModels
    + cultureLessons
    + placesModels
    + homeSessionsModels
}

enum JourneyType: Int, CaseIterable {
    case cocktails = 0
    case culture
    case places
    case homeSessions
}
