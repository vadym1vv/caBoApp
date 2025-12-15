//
//  JourneyDataLoader.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 12.12.2025.
//

import Foundation

class JourneyDataLoader {
    
    struct JourneyData: Codable {
        let cocktails: [CocktailModel]
        let culture: [CultureModel]
        let places: [PlacesModel]
        let homeSessions: [HomeSessionModel]
        
        
        static var empty: JourneyData {
            return JourneyData(cocktails: [], culture: [], places: [], homeSessions: [])
        }
    }
    
    static func loadData() -> JourneyData {
        
        guard let url = Bundle.main.url(forResource: "journey_data", withExtension: "json") else {
            print("⚠️ Error: 'journey_data.json' not found in Bundle. Check 'Copy Bundle Resources'.")
            return .empty
        }
        
        guard let data = try? Data(contentsOf: url) else {
            print("⚠️ Error: Could not read data from 'journey_data.json'.")
            return .empty
        }
        
        let decoder = JSONDecoder()
        
        do {
            let loadedData = try decoder.decode(JourneyData.self, from: data)
            return loadedData
        } catch {
            print("Decoding Error: \(error)")
            
            return .empty
        }
    }
}
