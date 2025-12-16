//
//  DificultyEnum.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

enum DifficultyEnum: String, Identifiable, CaseIterable, Codable {
    var id: String { rawValue } // Use rawValue for Identifiable
    
    // Case names must match JSON values exactly (all lowercase)
    case easy, medium, advanced
    
    @ViewBuilder
    var difficultyStars: some View {
        switch self {
        case .easy:
                Image(IconEnum.starDifficulty1Enum.icon)
        case .medium:
            HStack(spacing: 0) {
                Image(IconEnum.starDifficulty1Enum.icon)
                Image(IconEnum.starDifficulty1Enum.icon)
            }
        case .advanced:
            HStack(spacing: 0) {
                Image(IconEnum.starDifficulty1Enum.icon)
                Image(IconEnum.starDifficulty1Enum.icon)
                Image(IconEnum.starDifficulty1Enum.icon)
            }
        }
    }
}
