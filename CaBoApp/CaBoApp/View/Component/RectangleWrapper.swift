//
//  RectangleWrapper.swift
//  CaBoApp
//
//  Created by Vadym Vasylaki on 18.12.2025.
//

import SwiftUI

struct RectangleWrapperComponent<Component: View>: View {
    
    var component: Component
    
    var body: some View {
        HStack {
            component
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
                .font(FontEnum.joSaMedium14.font)
        }
        .background(ColorEnum.colFFFFFF.color)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    VStack {
        RectangleWrapperComponent(component: Text("Cocktail"))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(LinearGradientEnum.mainScreenBg.linearGradientColors)
}
