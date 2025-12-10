//
//  OnboardingEnum.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 10.12.2025.
//

import Foundation

enum OnboardingEum: Int, Identifiable, CaseIterable {
    var id: Self {self}
    case discoverCuban = 0, feelTheCulture = 1, createCuban = 2
    
    var title: String {
        switch self {
        case .discoverCuban:
            return "Discover Cuban flavors"
        case .feelTheCulture:
            return "Feel the culture at home"
        case .createCuban:
            return "Create your Cuban nights"
        }
    }
    
    var description: String {
        switch self {
        case .discoverCuban:
            return "Learn the stories behind classic Cuban drinks.\n\nSimple, guided recipes for your home bar."
        case .feelTheCulture:
            return "Lessons about Havana streets, daily rituals.\n\nBuild your own little Malecón"
        case .createCuban:
            return "Follow guided sessions: mix, feel, note.\n\nEverything works offline."
        }
    }
    
    var icon: String {
        switch self {
        case .discoverCuban:
            return IconEnum.onboardingImg1.icon
        case .feelTheCulture:
            return IconEnum.onboardingImg1.icon
        case .createCuban:
            return IconEnum.onboardingImg1.icon
        }
    }
}
