//
//  CoreDataUserProgressVM.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 12.12.2025.
//

import Foundation
import CoreData

class CoreDataUserProgressVM: CoreDataSettings {
    @Published var items: [ItemEntity] = []
    
    override init(container: NSPersistentContainer = CoreDataSettings.shared.container) {
        super.init(container: container)
        fetchEntity()
    }
    
    func updateFavoriteItem(itemName: String, categoryEnum: String, toggleFavorite: Bool? = nil, introducedDate: Date? = nil, searchedDate: Date? = nil) {
        let itemToUpdate = items.first(where: {$0.itemName == itemName}) ?? ItemEntity(context: container.viewContext)
        if (toggleFavorite != nil) {
            itemToUpdate.isFavorite = !itemToUpdate.isFavorite
        }
       
            itemToUpdate.itemType = categoryEnum
       
        if let introducedDate {
            itemToUpdate.introducedDate = introducedDate
        }
        itemToUpdate.itemName = itemName
        saveData()
        fetchEntity()
    }
    
    func fetchEntity() {
        items = fetchEntities(ItemEntity.self)
    }
    
    override func deleteAllEntities(entityName: String = "ItemEntity") {
        super.deleteAllEntities(entityName: entityName)
        fetchEntity()
    }
}
