
import Foundation
import SwiftUI

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
    
    static let viewComponentSpacing: CGFloat = UIScreen.main.bounds.height / 50
}

enum JourneyType: Int, CaseIterable {
    case cocktails = 0
    case culture
    case places
    case homeSessions
}
