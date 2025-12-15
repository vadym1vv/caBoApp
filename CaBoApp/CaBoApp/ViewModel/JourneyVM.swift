//
//  JourneyVM.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import Foundation
import SwiftUI

struct JourneyStorage {
    private static let typeKey = "lastJourneyType"
    private static let indexKey = "lastItemIndex"

    static func saveJournyrState(type: JourneyType, index: Int) {
        UserDefaults.standard.set(type.rawValue, forKey: typeKey)
        UserDefaults.standard.set(index, forKey: indexKey)
    }


    static func load() -> (type: JourneyType, index: Int) {
        let typeRaw = UserDefaults.standard.integer(forKey: typeKey)
        let index = UserDefaults.standard.integer(forKey: indexKey)
        
       
        let type = JourneyType(rawValue: typeRaw) ?? .cocktails
        
        return (type, index)
    }
}

class JourneyManager: ObservableObject {
    @Published var currentType: JourneyType
    @Published var currentIndex: Int
    
    init() {
       
        let savedState = JourneyStorage.load()
        self.currentType = savedState.type
        self.currentIndex = savedState.index
    }
    
    func next() {
       
        let maxCount: Int
        switch currentType {
        case .cocktails: maxCount = GlobalConstant.cocktailsModels.count
        case .culture:   maxCount = GlobalConstant.cultureLessons.count
        case .places:    maxCount = GlobalConstant.placesModels.count
        case .homeSessions: maxCount = GlobalConstant.homeSessionsModels.count
        }
        
       
        if currentIndex < maxCount - 1 {
            currentIndex += 1
        } else {
            
            if let nextType = JourneyType(rawValue: currentType.rawValue + 1) {
                currentType = nextType
                currentIndex = 0
            } else {
               
                currentType = .cocktails
                currentIndex = 0
            }
        }
        
    
        JourneyStorage.saveJournyrState(type: currentType, index: currentIndex)
    }
  
    var currentCocktail: CocktailModel? {
        guard currentType == .cocktails,
              GlobalConstant.cocktailsModels.indices.contains(currentIndex) else { return nil }
        return GlobalConstant.cocktailsModels[currentIndex]
    }
    
    var currentCulture: CultureModel? {
        guard currentType == .culture,
              GlobalConstant.cultureLessons.indices.contains(currentIndex) else { return nil }
        return GlobalConstant.cultureLessons[currentIndex]
    }
    
    var currentPlace: PlacesModel? {
        guard currentType == .places,
              GlobalConstant.placesModels.indices.contains(currentIndex) else { return nil }
        return GlobalConstant.placesModels[currentIndex]
    }
    
    var currentSession: HomeSessionModel? {
        guard currentType == .homeSessions,
              GlobalConstant.homeSessionsModels.indices.contains(currentIndex) else { return nil }
        return GlobalConstant.homeSessionsModels[currentIndex]
    }
}


extension JourneyManager {
    
    var totalItemsCount: Int {
        GlobalConstant.cocktailsModels.count +
        GlobalConstant.cultureLessons.count +
        GlobalConstant.placesModels.count +
        GlobalConstant.homeSessionsModels.count
    }
    
    var completedItemsCount: Int {
        var count = 0

        if currentType.rawValue > JourneyType.cocktails.rawValue {
            count += GlobalConstant.cocktailsModels.count
        }
        if currentType.rawValue > JourneyType.culture.rawValue {
            count += GlobalConstant.cultureLessons.count
        }
        if currentType.rawValue > JourneyType.places.rawValue {
            count += GlobalConstant.placesModels.count
        }

        count += currentIndex
        return count
    }
    
    var currentPrecentProgress: Int {
        guard totalItemsCount > 0 else { return 0 }
        let progress = (Double(completedItemsCount) / Double(totalItemsCount)) * 100
        return Int(progress)
    }
    
    var totalProgressWidth: CGFloat {
        UIScreen.main.bounds.width / 2 - 40
    }
    
    var readProgressWidth: CGFloat {
        guard currentPrecentProgress > 0 else { return 0 }
        return CGFloat(currentPrecentProgress) / 100 * totalProgressWidth
    }
}
