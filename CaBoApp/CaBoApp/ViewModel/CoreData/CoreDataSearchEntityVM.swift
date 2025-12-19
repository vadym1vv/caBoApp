
import Foundation
import CoreData

class CoreDataSearchEntityVM: CoreDataSettings {
    @Published var searchRequests: [SearchEntity] = []
    
    override init(container: NSPersistentContainer = CoreDataSettings.shared.container) {
        super.init(container: container)
        fetchEntity()
    }
    
    func updateItem(searchRequest: String?, type: String?, mood: String?, difficulty: String?, timeNeeded: String?,  searchDate: Date = Date()) {
        
        if (!searchRequests.contains(where: {$0.searchString == searchRequest && $0.typeCategory == type && $0.mood == mood && $0.difficulty == difficulty && $0.timeNeeded == timeNeeded})) {
            let searchEntity = SearchEntity(context: container.viewContext)
            searchEntity.searchString = searchRequest
            searchEntity.searchDate = searchDate
            searchEntity.typeCategory = type
            searchEntity.mood = mood
            searchEntity.difficulty = difficulty
            searchEntity.timeNeeded = timeNeeded
            saveData()
            fetchEntity()
        }
    }
    
    func deleteSearchRequest(searchEntity: SearchEntity?) {
        if let searchEntity {
            container.viewContext.delete(searchEntity)
            saveData()
            fetchEntity()
        }
    }
    
    func fetchEntity() {
        searchRequests = fetchEntities(SearchEntity.self)
    }
    
    override func deleteAllEntities(entityName: String = "SearchEntity") {
        super.deleteAllEntities(entityName: entityName)
        fetchEntity()
    }
}
