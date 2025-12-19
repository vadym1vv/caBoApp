
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
    
    var longDescription: String {
        switch self {
        case .coctails:
            return "Learned cocktails"
        case .cultureLessons:
            return "Familiar with the culture"
        case .places:
            return "Places viewed"
        case .homeSessions:
            return "Sessions completed"
        }
    }
    
    var color: Color {
        switch self {
        case .coctails:
            return ColorEnum.colFF6F61.color
        case .cultureLessons:
            return ColorEnum.col008080.color
        case .places:
            return ColorEnum.colF98F75.color
        case .homeSessions:
            return ColorEnum.col926EF8.color
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
