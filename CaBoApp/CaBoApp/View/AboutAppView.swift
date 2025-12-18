//
//  AboutAppView.swift
//  CaBoApp
//
//  Created by Vadym Vasylaki on 18.12.2025.
//

import SwiftUI

struct AboutAppView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @AppStorage("isLightTheme") private var isLightTheme: Bool = true
    
    var body: some View {
        VStack {
            TopBarNavigationComponent(leadingView: HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(IconEnum.backBtn.icon)
                }
                Text("About CaBo App")
                    .font(FontEnum.joSaBold24.font)
                   
                
            }, centerView: EmptyView(), trailingView: EmptyView())
            .padding(.top, getSafeArea().top)
            VStack(spacing: 24) {
                Image(IconEnum.caboLogo.icon)
                Text("Version\(Bundle.main.semanticVersion)")
                    .font(FontEnum.joSaMedium18.font)
                Text("CaBo App is your offline companion to Cuban flavors and stories.")
                    .multilineTextAlignment(.center)
                    .font(FontEnum.joSaLRegular18.font)
                
                HStack {
                    Image(IconEnum.offlinePhone.icon)
                    Text("Everything offline")
                        .font(FontEnum.joSaRegular16.font)
                }
                
            }
            .padding(.horizontal, UIScreen.main.bounds.width / 10)
            .padding(.top)
            Spacer()
            VStack(spacing: 12) {
                Button {
#warning("Privacy Policy on safari")
                    if let url = URL(string: "https://google.com") {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    Text("Privacy Policy")
                        .frame(maxWidth: .infinity)
                        .frame(height: UIScreen.main.bounds.height / 18)
                        .background(ColorEnum.colFF5D4D.color)
                        .foregroundColor(ColorEnum.colFFFFFF.color)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                }
                
                Button {
#warning("Terms of Use on safari")
                    if let url = URL(string: "https://google.com") {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    Text("Terms of Use")
                        .frame(maxWidth: .infinity)
                        .frame(height: UIScreen.main.bounds.height / 18)
                        .background(ColorEnum.colFFFFFF.color)
                        .foregroundColor(ColorEnum.col181818.color)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                }
                
            }
            .padding(.bottom, getSafeArea().bottom)
            .padding(.horizontal, UIScreen.main.bounds.width / 10)
            .font(FontEnum.joSaMedium16.font)
            //            .frame(width:  UIScreen.main.bounds.width / 1.4)
        }
        .foregroundColor(isLightTheme ? ColorEnum.col181818.color : ColorEnum.colFFFFFF.color)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(ColorEnum.col181818.color)
        .background(isLightTheme ? LinearGradientEnum.mainScreenBg.linearGradientColors : LinearGradientEnum.darkBackgorund.linearGradientColors)
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
    
}

#Preview {
    AboutAppView()
}

extension Bundle {
    var semanticVersion: String {
        guard let version = infoDictionary?["CFBundleShortVersionString"] as? String else {
            return "0.0.0"
        }
        
        let components = version.split(separator: ".")
        if components.count == 1 {
            return "\(version).0.0"
        } else if components.count == 2 {
            return "\(version).0"
        }
        return version
    }
}
