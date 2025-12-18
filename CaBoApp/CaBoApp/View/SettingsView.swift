//
//  SettingsView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

struct SettingsView: View {
    
    
    @AppStorage("isLightTheme") private var isLightTheme: Bool = true
    @State private var sessionReminder: Bool = false
    
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
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
                VStack {
                    HStack  {
                        Image(IconEnum.lockIcon.icon)
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Export data (CSV/JSON)")
                                .font(FontEnum.joSaMedium18.font)
                            Text("Export your journal and sessions to a file.")
                                .font(FontEnum.joSaLight16.font)
                        }
                        Spacer()
                        Text("$1.99")
                            .font(FontEnum.joSaBold16.font)
                    }
                    .padding([.top, .horizontal])
                    Button {
                        
                    } label: {
                        HStack {
                            Image(IconEnum.lockIconSmall.icon)
                            Text("Unlock Export")
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
                        Text("$1.99")
                            .font(FontEnum.joSaBold16.font)
                    }
                    .padding([.top, .horizontal])
                    Button {
                        
                    } label: {
                        HStack {
                            Image(IconEnum.lockIconSmall.icon)
                            Text("Unlock Export")
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
        .font(FontEnum.joSaMedium20.font)
        .foregroundColor(ColorEnum.col181818.color)
        .background(LinearGradientEnum.mainScreenBg.linearGradientColors)
        .ignoresSafeArea()
        .navigationBarHidden(true)
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
