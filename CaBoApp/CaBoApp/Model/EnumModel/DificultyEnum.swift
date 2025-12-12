//
//  DificultyEnum.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import Foundation

enum DificultyEnum: Identifiable, CaseIterable {
    var id: Self {self}
    case easy, medium, advanced
}
