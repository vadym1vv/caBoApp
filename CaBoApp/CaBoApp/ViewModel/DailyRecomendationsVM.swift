//
//  DailyRecomendationsVM.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import Foundation
class DailyRecomendationsMV: ObservableObject {
    
    @Published var recomendationKey1 = UserDefaults.standard.integer(forKey: "recomendationIndex1")
    @Published var recomendationKey2 = UserDefaults.standard.integer(forKey: "recomendationIndex2")
    @Published var recomendationKey3 = UserDefaults.standard.integer(forKey: "recomendationIndex3")
    
    func updateRecomendationsByDate() {
        let today = Calendar.current.startOfDay(for: Date())
        
        let storedDate = UserDefaults.standard.object(forKey: "lastRecomdationDateDay") as? Date
        
        if let storedDate, Calendar.current.isDate(storedDate, inSameDayAs: today) {
            return
        }

        generateNewRecommendations()
        
        UserDefaults.standard.set(today, forKey: "lastRecomdationDateDay")
    }
    
    func generateNewRecommendations() {
        let indices = Array(GlobalConstant.journayCollections.indices)
        
        guard indices.count >= 3 else {
            print("Not enough items to generate recommendations.")
            return
        }
        
        let shuffled = indices.shuffled()
        
        recomendationKey1 = shuffled[0]
        recomendationKey2 = shuffled[1]
        recomendationKey3 = shuffled[2]
        
        UserDefaults.standard.set(recomendationKey1, forKey: "recomendationIndex1")
        UserDefaults.standard.set(recomendationKey2, forKey: "recomendationIndex2")
        UserDefaults.standard.set(recomendationKey3, forKey: "recomendationIndex3")
    }
}
