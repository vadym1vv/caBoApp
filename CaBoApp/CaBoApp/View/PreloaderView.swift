
import SwiftUI

struct PreloaderView: View {
    
    @State private var navigateToOnboarding = false
    @State private var navigateToMainScreen = false
    @State private var isSpinning = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(IconEnum.caboLogo.icon)
                    .zIndex(1)
                
                Image(IconEnum.previewBackground.icon)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    NavigationLink(isActive: $navigateToOnboarding) {
                        OnboardingView()
                    } label: { EmptyView() }
                    
                    NavigationLink(isActive: $navigateToMainScreen) {
                        RootTabView()
                    } label: { EmptyView() }
                    
                    Spacer()
                    
                    Text("Cuba in your glass. Cuba in your room.")
                        .font(FontEnum.daScRegular24.font)
                        .foregroundColor(ColorEnum.colFFFFFF.color)
                    
                    Image(IconEnum.rotationIndicator.icon)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .rotationEffect(.degrees(isSpinning ? 360 : 0))
                        .animation(
                            .linear(duration: 1)
                            .repeatForever(autoreverses: false),
                            value: isSpinning
                        )
                        .onAppear {
                            isSpinning = true
                        }
                        .padding(.top)
                        .padding(.bottom, UIScreen.main.bounds.height / 5)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        if UserDefaults.standard.bool(forKey: "isFirstOpening") {
                            navigateToOnboarding = true
                        } else {
                            navigateToMainScreen = true
                        }
                    }
                }
            }
        }
    }
}

struct PreloaderView_Previews: PreviewProvider {
    static var previews: some View {
        PreloaderView()
    }
}
