//
//  TimeForSessionEnum.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import Foundation

enum TimeForSessionEnum: String, CaseIterable, Identifiable, Codable {
    var id: String { rawValue }
    
    // Clean cases (no raw value = case name is the value)
    case tenTwenty
    case twentyFive
    case twenty
    case fortyPlus
    
    // Typos in the JSON are manually mapped here:
    case thirtyFive = "thortyFive" // Fixes the Index 3, Index 4 typo
    case twentyForty = "twentyFourty" // Fixes the Index 5, Index 7 typo
    
    // Computed property for display purposes
    var uiTitle: String {
        switch self {
        case .tenTwenty: return "10-20min"
        case .twentyForty: return "20-40min"
        case .twentyFive: return "25 min"
        case .fortyPlus: return "40+ min"
        case .twenty: return "20 min"
        case .thirtyFive: return "35 min"
        }
    }
}
