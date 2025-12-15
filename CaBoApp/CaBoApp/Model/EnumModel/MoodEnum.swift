//
//  MoodEnum.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import Foundation

enum MoodEnum: String, Identifiable, CaseIterable, Codable {
    var id: String { rawValue } // Use rawValue for Identifiable
    
    // Case names must match JSON values exactly (all lowercase)
    case relax, party, deep, romantic
}
