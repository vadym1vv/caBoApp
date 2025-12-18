//
//  SettingsView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

struct SettingsView: View {
    
    
    @AppStorage("isLightTheme") private var isLightTheme: Bool = true
    @AppStorage("com.caboapp.export") private var isExportUnlocked: Bool = false
        @AppStorage("com.caboapp.reset") private var isResetUnlocked: Bool = false
    @State private var sessionReminder: Bool = false
    
    @State private var showUnlockExportPaywall: Bool = false
    @State private var showUnlockResetPaywall: Bool = false
    
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        ZStack {
            if (showUnlockResetPaywall || showUnlockExportPaywall){
                ColorEnum.col181818.color.opacity(0.7)
                    .zIndex(1)
            }
            
            if (showUnlockResetPaywall) {
                PaywallComponent(showPurchasePlaywall: $showUnlockResetPaywall, titleIcon: .exportDataIcon, purchaseTitle: "Export data (CSV/JSON)", purchaseDescription: "Enable export to CaBo to save recipes, rituals, and cultural sessions for your projects.", purchaseButtonLabel: "Unlock Export") {
                    if !isResetUnlocked {
                        IAPManager.shared.purchase(productID: "com.caboapp.reset")
                    }
                }
            }
            
            if (showUnlockExportPaywall) {
                PaywallComponent(showPurchasePlaywall: $showUnlockResetPaywall, titleIcon: .resetIcon, purchaseTitle: "Reset progress", purchaseDescription: "This one-time purchase lets you completely reset your CaBo journey whenever you want.", purchaseButtonLabel: "Unlock Reset") {
                    if !isExportUnlocked {
                        IAPManager.shared.purchase(productID: "com.caboapp.export")
                    }
                }
            }
            
            VStack {
                TopBarNavigationComponent(leadingView: HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(IconEnum.backBtn.icon)
                    }
                    Text("Settings")
                        .font(FontEnum.joSaBold24.font)
                    
                }, centerView: EmptyView(), trailingView: EmptyView())
                .padding(.top, getSafeArea().top)
                
                VStack(alignment: .leading, spacing: GlobalConstant.viewComponentSpacing) {
                    Text("Themes/Appearance")
                    HStack {
                        Text("Theme")
                            .font(FontEnum.joSaMedium18.font)
                            .layoutPriority(1)
                            .padding(.leading)
                        Spacer()
                        ZStack {
                            if (isLightTheme) {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(ColorEnum.colFF6F61.color)
                            }
                            Button {
                                withAnimation {
                                    isLightTheme = true
                                }
                            } label: {
                                Text("Brisa Cubana")
                                    .font(FontEnum.joSaRegular16.font)
                                    .frame(maxHeight: .infinity)
                                
                            }
                        }
                        .frame(width: 110)
                        .padding(.vertical, 7)
                        
                        ZStack {
                            if (!isLightTheme) {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(ColorEnum.colFF6F61.color)
                            }
                            Button {
                                withAnimation {
                                    isLightTheme = false
                                }
                            } label: {
                                Text("Cuban Night")
                                    .font(FontEnum.joSaRegular16.font)
                                    .frame(maxHeight: .infinity)
                                
                            }
                        }
                        .frame(width: 110)
                        .padding(.vertical,7)
                        .padding(.trailing)
                    }
                    .frame(height: 54)
                    .background(ColorEnum.colFFC8AF.color)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    Text("Preferences")
                    HStack {
                        Text("Session reminder")
                            .font(FontEnum.joSaMedium18.font)
                            .padding()
                        Spacer()
                        Toggle(isOn: $sessionReminder) {
                            Text("")
                        }
                        .padding()
                    }
                    .frame(height: 54)
                    .background(ColorEnum.colFFC8AF.color)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Text("Data & Progress(IAP)")
                    if (isExportUnlocked) {
                        VStack {
                            HStack {
                                Image(IconEnum.exportDataIcon.icon)
                                Text("Export Data(CSV/JSON)")
                                    .font(FontEnum.joSaMedium18.font)
                            }
                                .font(FontEnum.joSaLight16.font)
                                .padding(.top, 5)
                            
                            HStack {
                                Button {
                                    showUnlockResetPaywall = true
                                } label: {
                                    Text("Export in CSV format")
                                        .font(FontEnum.joSaRegular16.font)
                                        .frame(maxWidth: .infinity)
                                        .padding(.horizontal, 3)
                                        .font(FontEnum.joSaRegular16.font)
                                        .frame(minHeight: 44)
                                        .background(ColorEnum.colFFA07A.color)
                                        .foregroundColor(ColorEnum.col181818.color)
                                        .clipShape(RoundedRectangle(cornerRadius: 24))
                                }
                               
                               
                                Button {
                                    showUnlockExportPaywall = true
                                } label: {
                                    Text("Export in JSON format")
                                        .font(FontEnum.joSaRegular16.font)
                                        .frame(maxWidth: .infinity)
                                        .frame(minHeight: 44)
                                        .padding(.horizontal, 3)
                                        .background(ColorEnum.colFFA07A.color)
                                        .foregroundColor(ColorEnum.col181818.color)
                                        .clipShape(RoundedRectangle(cornerRadius: 24))
                                }
                               
                            }
                            .padding([.horizontal, .bottom], 6)
                        }
                        .background(ColorEnum.colFFC8AF.color)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    } else {
                        VStack {
                            HStack  {
                                Image(isExportUnlocked ? IconEnum.resetIcon.icon : IconEnum.lockIcon.icon)
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Export data (CSV/JSON)")
                                        .font(FontEnum.joSaMedium18.font)
                                    Text("Export your journal and sessions to a file.")
                                        .font(FontEnum.joSaLight16.font)
                                }
                                Spacer()
                                if !isExportUnlocked { Text("$1.99").font(FontEnum.joSaBold16.font) }
                            }
                            .padding([.top, .horizontal])
                            Button {
                                showUnlockExportPaywall = true
                            } label: {
                                HStack {
                                    if !isExportUnlocked { Image(IconEnum.lockIconSmall.icon) }
                                    Text(isExportUnlocked ? "Export Unlocked" : "Unlock Export")
                                        .font(FontEnum.joSaMedium16.font)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: UIScreen.main.bounds.height / 18)
                                .background(ColorEnum.colFF6F61.color)
                                .foregroundColor(ColorEnum.colFFFFFF.color)
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                            }
                            .padding()
                        }
                        .background(ColorEnum.colFFC8AF.color)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    if(!isResetUnlocked) {
                        VStack {
                            HStack  {
                                Image(IconEnum.lockIcon.icon)
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Reset progress")
                                        .font(FontEnum.joSaMedium18.font)
                                    Text("Unlock the option to wipe all local data and start fresh.")
                                        .font(FontEnum.joSaLight16.font)
                                }
                                Spacer()
                                if !isResetUnlocked { Text("$1.99").font(FontEnum.joSaBold16.font) }
                            }
                            .padding([.top, .horizontal])
                          
                            Button {
                                showUnlockResetPaywall = true
                            } label: {
                                HStack {
                                    Image(IconEnum.lockIconSmall.icon)
                                    Text("Unlock Reset")
                                        .font(FontEnum.joSaMedium16.font)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: UIScreen.main.bounds.height / 18)
                                .background(ColorEnum.colF77D4E.color)
                                .foregroundColor(ColorEnum.colFFFFFF.color)
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                            }
                            .padding()
                        }
                        .background(ColorEnum.colFFC8AF.color)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                VStack {
                    if (false) {
                        Button {
                            
                        } label: {
                            HStack {
                                Image(IconEnum.resetIcon.icon)
                                Text("Reset progress")
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: UIScreen.main.bounds.height / 18)
                            .background(ColorEnum.colFF5D4D.color)
                            .foregroundColor(ColorEnum.colFFFFFF.color)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                        }
                    }
                    
                   
                        NavigationLink {
                            AboutAppView()
                        } label: {
                            HStack {
                                Image(IconEnum.aboutAppIcon.icon)
                                Text("About the app")
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: UIScreen.main.bounds.height / 18)
                            .background(ColorEnum.colFFFFFF.color)
                            .foregroundColor(ColorEnum.col181818.color)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                        }
                    
                }
    //            .padding(.bottom, 15)
                .frame(width:  UIScreen.main.bounds.width / 1.4)
                Spacer()
                
            }
        }
        .font(FontEnum.joSaMedium20.font)
        .foregroundColor(ColorEnum.col181818.color)
        .background(LinearGradientEnum.mainScreenBg.linearGradientColors)
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .onAppear {
                    IAPManager.shared.fetchProducts()
                }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
