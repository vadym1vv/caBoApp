//
//  TimeForSessionEnum.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import Foundation

enum TimeForSessionEnum: String, CaseIterable, Identifiable {
    var id: Self {self}
    case tenTwenty = "10-20min", twentyFourty = "20-40min", twentyFive = "25 min", fortyPlus = "40+ min", twenty = "20 min", thortyFive = "35 min"
}
