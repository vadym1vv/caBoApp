//
//  ColorEnum.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 10.12.2025.
//

import SwiftUI

enum ColorEnum: String {
    case col004A4A, col20B2AA, col926EF8, col7443FF, col008080, col181818, colC4E9E1, colEDE7FA, colF0A89A, colF98F75, colFF4E4E, colFF5D4D, colFF6F61, colFFA07A, colFFC8AF, colFFE0D4, colFFFFFF, darkBg1, darkBg2, darkBg3, darkBg4, darkBg5, mainBg1, mainBg2, mainBg3, onboardingBg1, onboardingBg2, onboardingBg3, onboardingBg4, onboardingBg5, onboardingBg6, onboardingBtn1, onboardingBtn2, onboardingBtn3, tabBarBg1, tabBarBg2, tabBarBg3, colC4C4C4, col47338F, col47338F30, colF77D4E
    
    var color: Color {
        return Color(self.rawValue)
    }
}
