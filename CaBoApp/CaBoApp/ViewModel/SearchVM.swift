
import Foundation

class SearchVM: ObservableObject {
    @Published var searchInput: String? = nil
    @Published var typeCategory: CategoryEnum? = nil
    @Published var moodEnum: MoodEnum? = nil
    @Published var difficultyEnum: DifficultyEnum? = nil
    @Published var timeForSession: TimeForSessionEnum? = nil
    
    
    func performSearch() -> [any CategoryProtocol] {
        
        var results = GlobalConstant.journayCollections
        
        if let category = typeCategory {
            switch category {
            case .coctails:
                results = results.filter { $0 is CocktailModel }
            case .cultureLessons:
                results = results.filter { $0 is CultureModel }
            case .places:
                results = results.filter { $0 is PlacesModel }
            case .homeSessions:
                results = results.filter { $0 is HomeSessionModel }
            }
        }
        
        if let searchText = searchInput, !searchText.isEmpty {
            results = results.filter { item in
                item.title.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        if let mood = moodEnum {
            results = results.filter { item in
                return item.modeEnum == mood
            }
        }
        
        if let difficulty = difficultyEnum {
            results = results.filter { item in
                if let cocktail = item as? CocktailModel {
                    return cocktail.dificulty.rawValue == difficulty.rawValue
                }
                if let session = item as? HomeSessionModel {
                    return session.dificulty.rawValue == difficulty.rawValue
                }
                
                return false
            }
        }
        
        if let time = timeForSession {
            results = results.filter { item in
                if let session = item as? HomeSessionModel {
                    return session.timeForSession.rawValue == time.rawValue
                }
                return false
            }
        }
        
        return results
    }
    
    func resetSearchCriteria() {
        searchInput = nil
        typeCategory = nil
        moodEnum = nil
        difficultyEnum = nil
        timeForSession = nil
    }
}
