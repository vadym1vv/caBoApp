
import Foundation
import CoreData

class CoreDataJournalVM: CoreDataSettings {
    @Published var journalItemEntities: [JournalItemEntity] = []
    
    override init(container: NSPersistentContainer = CoreDataSettings.shared.container) {
        super.init(container: container)
        fetchEntity()
    }
    
    func registerNewJournalEntity(itemTitle: String, itemCategory: String, date: Date = Date()) {
        let newItem = JournalItemEntity(context: container.viewContext)
        newItem.itemTitle = itemTitle
        newItem.itemCategory = itemCategory
        newItem.date = date
        saveData()
        fetchEntity()
    }
    
    func getEntitiesForJournal() -> [any CategoryProtocol] {
        var journalEntities: [any CategoryProtocol] = []
        journalItemEntities.forEach { journalEntity in
            if let categoryProtocolModen = GlobalConstant.journayCollections.first(where: {$0.title == journalEntity.itemTitle}) {
                journalEntities.append(categoryProtocolModen)
            }
        }
        return journalEntities
    }
    
    func deleteJournalEntity(journalEntity: JournalItemEntity) {
        container.viewContext.delete(journalEntity)
        saveData()
        fetchEntity()
    }
    
    func fetchEntity() {
        journalItemEntities = fetchEntities(JournalItemEntity.self)
    }
    
    override func deleteAllEntities(entityName: String = "JournalItemEntity") {
        super.deleteAllEntities(entityName: entityName)
        fetchEntity()
    }
}
