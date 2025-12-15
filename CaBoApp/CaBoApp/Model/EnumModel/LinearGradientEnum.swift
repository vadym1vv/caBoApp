//
//  LinearGradientEnum.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 10.12.2025.
//

import SwiftUI

enum LinearGradientEnum {
    case onboardingBg, onboardingBtnBg, mainScreenBg, tabBarBgHorizontal, tabBarBgVertical, darkBackgorund, yellowSingleItemBackground, greenSingleItemBackground, purpleSingleItemBackground
    
    var linearGradientColors: LinearGradient {
        switch self {
        case .onboardingBg:
            return LinearGradient(colors: [ColorEnum.onboardingBg1.color,
                                           ColorEnum.onboardingBg2.color,
                                           ColorEnum.onboardingBg3.color,
                                           ColorEnum.onboardingBg4.color,
                                           ColorEnum.onboardingBg5.color,
                                           ColorEnum.onboardingBg6.color]
                                  , startPoint: .top, endPoint: .bottom)
        case .onboardingBtnBg:
            return LinearGradient(colors: [ColorEnum.onboardingBtn1.color,
                                           ColorEnum.onboardingBtn2.color,
                                           ColorEnum.onboardingBtn3.color], startPoint: .leading, endPoint: .trailing)
        case .mainScreenBg:
            return LinearGradient(colors: [ColorEnum.mainBg1.color,
                                           ColorEnum.mainBg2.color,
                                           ColorEnum.mainBg3.color], startPoint: .top, endPoint: .bottom)
        case .tabBarBgHorizontal:
            return LinearGradient(colors: [ColorEnum.tabBarBg1.color,
                                           ColorEnum.tabBarBg2.color,
                                           ColorEnum.tabBarBg3.color], startPoint: .leading, endPoint: .trailing)
        case .tabBarBgVertical:
            return LinearGradient(colors: [ColorEnum.tabBarBg1.color,
                                           ColorEnum.tabBarBg2.color,
                                           ColorEnum.tabBarBg3.color], startPoint: .top, endPoint: .bottom)
        case .darkBackgorund:
            return LinearGradient(colors: [ColorEnum.darkBg1.color,
                                           ColorEnum.darkBg2.color,
                                           ColorEnum.darkBg3.color,
                                           ColorEnum.darkBg4.color,
                                           ColorEnum.darkBg5.color], startPoint: .top, endPoint: .bottom)
        case .yellowSingleItemBackground:
            return LinearGradient(colors: [ColorEnum.colFFFFFF.color, ColorEnum.colFFC8AF.color], startPoint: .top, endPoint: .bottom)
        case .greenSingleItemBackground:
            return LinearGradient(colors: [ColorEnum.colFFFFFF.color, ColorEnum.colC4E9E1.color], startPoint: .top, endPoint: .bottom)
        case .purpleSingleItemBackground:
            return LinearGradient(colors: [ColorEnum.colFFFFFF.color, ColorEnum.colEDE7FA.color], startPoint: .top, endPoint: .bottom)
        }
    }
}

struct LinearGradientEnum_Previews: PreviewProvider {
    static var previews: some View {
        VStack {}
            .frame(width: 100)
            .frame(maxHeight: .infinity)
            .background(LinearGradientEnum.onboardingBg.linearGradientColors)
    }
}



