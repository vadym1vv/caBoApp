//
//  TabBarNavigationComponent.swift
//  CaBoApp
//
//  Created by Vadym Vasylaki on 15.12.2025.
//

import SwiftUI

struct TabBarNavigationComponent: View {
    
    @Binding var selectedTabComponentEnum: TabComponentEnum
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(ColorEnum.colFFFFFF.color)
                Circle()
                    .fill(LinearGradientEnum.tabBarBgVertical.linearGradientColors)
                    .padding(0.5)
                Image(selectedTabComponentEnum.tabIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(height: UIScreen.main.bounds.height / 22)
            }
            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
            
            ZStack {
                RoundedRectangle(cornerRadius: 60)
                    .foregroundColor(ColorEnum.colFFFFFF.color)
                    
                HStack {
                    ForEach(TabComponentEnum.allCases) { tab in
                        if(tab != selectedTabComponentEnum) {
                            Button {
                                withAnimation {
                                    selectedTabComponentEnum = tab
                                }
                            } label: {
                                VStack {
                                    Image(tab.tabIcon)
                                    Text(tab.rawValue.capitalized)
                                        .font(FontEnum.joSaMedium14.font)
                                }
                                .frame(maxWidth: .infinity)
                                .foregroundColor(ColorEnum.colFFFFFF.color)
                            }
                           
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                .background(LinearGradientEnum.tabBarBgHorizontal.linearGradientColors)
                .clipShape(RoundedRectangle(cornerRadius: 60))
                .padding(0.5)
                
            }
        }
        .frame(height: UIScreen.main.bounds.height / 12)
    }
}

#Preview {
    VStack {
        Spacer()
        TabBarNavigationComponent(selectedTabComponentEnum: .constant(.home))
            .padding(.horizontal)
    }
    .background(LinearGradientEnum.mainScreenBg.linearGradientColors)
}
