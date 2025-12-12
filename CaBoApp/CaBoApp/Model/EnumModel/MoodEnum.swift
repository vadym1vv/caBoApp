//
//  MoodEnum.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import Foundation

enum MoodEnum: Identifiable, CaseIterable {
    var id: Self {self}
    case relax, party, deep, romantic
}
