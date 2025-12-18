//
//  PaywallComponent.swift
//  CaBoApp
//
//  Created by Vadym Vasylaki on 18.12.2025.
//

import SwiftUI

struct PaywallComponent: View {
    
    @Binding var showPurchasePlaywall: Bool
    let titleIcon: IconEnum?
    let unlockIcon: IconEnum?
    var laterIcon: IconEnum? = IconEnum.laterIcon
    let purchaseTitle: String
    let purchaseDescription: String
    var purchaseButtonLabel: String
    var cancelBtnDescription: String = "Maybe later"
    var unlockAction: () -> ()
    
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                HStack {
                    if let titleIcon {
                        Image(titleIcon.icon)
                            .renderingMode(.template)
                            .foregroundColor(ColorEnum.colFF6F61.color)
                    }
                    Text(purchaseTitle)
                        .font(FontEnum.joSaMedium18.font)
                }
                Text(purchaseDescription)
                    .font(FontEnum.joSaRegular14.font)
                if(titleIcon != nil) {
                    Text("$1.99")
                        .font(FontEnum.joSaBold18.font)
                        .foregroundColor(ColorEnum.col181818.color)
                }
                Button {
                    unlockAction()
                    withAnimation {
                        showPurchasePlaywall = false
                    }
                } label: {
                    HStack {
                        if let unlockIcon{
                            Image(unlockIcon.icon)
                                .renderingMode(.template)
                                .foregroundColor(ColorEnum.colFFFFFF.color)
                        }
                        Text(purchaseButtonLabel)
                            .foregroundColor(ColorEnum.colFFFFFF.color)
                    }
                    .padding(.vertical, 10)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .background(ColorEnum.colFF6F61.color)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    
                }
                
                Button {
                    withAnimation {
                        showPurchasePlaywall = false
                    }
                } label: {
                    HStack {
                        if let laterIcon {
                            Image(laterIcon.icon)
                        }
                        Text(cancelBtnDescription)
                            .foregroundColor(ColorEnum.col181818.color)
                    }
                    .padding(.vertical, 10)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .background(ColorEnum.colFFC8AF.color)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .frame(maxWidth: UIScreen.main.bounds.width / 4)
                }
            }
            .foregroundColor(ColorEnum.col181818.color)
            .padding()
        }
        .background(ColorEnum.colFFFFFF.color)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}

#Preview {
    VStack {
        PaywallComponent(showPurchasePlaywall: .constant(true), titleIcon: .exportDataIcon, unlockIcon: .resetIcon, purchaseTitle: "Export data (CSV/JSON)", purchaseDescription: "Enable export to CaBo to save recipes, rituals, and cultural sessions for your projects.", purchaseButtonLabel: "Unlock Export", unlockAction: {})
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(LinearGradientEnum.mainScreenBg.linearGradientColors)
}
