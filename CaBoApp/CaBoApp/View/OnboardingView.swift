
import SwiftUI

struct OnboardingView: View {
    
    @State private var selectedTab: OnboardingEum = .discoverCuban
    
    var body: some View {
        VStack {
            VStack(spacing: UIScreen.main.bounds.height / 20) {
                HStack  {
                    if (selectedTab.rawValue >= OnboardingEum.allCases.count - 1) {
                        Button {
                            withAnimation {
                                selectedTab = .discoverCuban
                            }
                        } label: {
                            Text("Back")
                                .frame(height: 36)
                                .padding(.horizontal)
                                .foregroundColor(ColorEnum.colFF5D4D.color)
                                .background(ColorEnum.colFFFFFF.color)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    }
                    Spacer()
                    NavigationLink {
                        RootTabView()
                    } label: {
                        Text("SKIP")
                            .frame(height: 36)
                            .padding(.horizontal)
                            .foregroundColor(ColorEnum.colFF5D4D.color)
                            .background(ColorEnum.colFFFFFF.color)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                .padding(.top, getSafeArea().top)
                .font(FontEnum.joSaMedium16.font)
                
                VStack {
                    TabView(selection: $selectedTab) {
                        ForEach(OnboardingEum.allCases) { onboarding in
                            VStack {
                                Text(onboarding.title)
                                    .font(FontEnum.joSaMedium20.font)
                                Image(onboarding.icon)
                                    .resizable()
                                    .scaledToFit()
                                
                                Text(onboarding.description)
                                    .font(FontEnum.joSaRegular16.font)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    
                    HStack {
                        ForEach(OnboardingEum.allCases.indices, id: \.self) { tabIndex in
                            Circle()
                                .frame(width: 12, height: 12)
                                .foregroundColor(selectedTab.rawValue == tabIndex ? ColorEnum.colFF6F61.color : ColorEnum.colC4C4C4.color)
                        }
                    }
                    .padding(.bottom)
                }
                .background(ColorEnum.colFFFFFF.color)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                if (selectedTab.rawValue < OnboardingEum.allCases.count - 1) {
                    Button {
                        withAnimation {
                            selectedTab = OnboardingEum(rawValue: selectedTab.rawValue + 1)!
                        }
                    } label: {
                        Text("CONTINUE")
                            .font(FontEnum.joSaBold16.font)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(LinearGradientEnum.onboardingBtnBg.linearGradientColors)
                            .foregroundColor(ColorEnum.colFFFFFF.color)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                    }
                    .padding(.bottom, getSafeArea().bottom + 10)
                    
                } else {
                    NavigationLink {
                        RootTabView()
                    } label: {
                        Text("START EXPLORING")
                            .font(FontEnum.joSaBold16.font)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(LinearGradientEnum.onboardingBtnBg.linearGradientColors)
                            .foregroundColor(ColorEnum.colFFFFFF.color)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                    }
                    .padding(.bottom, getSafeArea().bottom + 10)
                    
                }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradientEnum.onboardingBg.linearGradientColors)
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OnboardingView()
        }
    }
}
