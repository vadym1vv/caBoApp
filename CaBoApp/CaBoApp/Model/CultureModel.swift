//
//  CultureMode.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import Foundation

struct CultureModel: CategoryProtocol, Codable, Identifiable {
    var id: String { title + image }
    let title: String
    let image: String
    let modeEnum: MoodEnum
    let origin: String
    let story: String
    let facts: String
}
