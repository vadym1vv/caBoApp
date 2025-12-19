
import SwiftUI

struct RootTabView: View {
    @AppStorage("isLightTheme") private var isLightTheme: Bool = true
    
    @StateObject private var coreDataUserProgressVM: CoreDataUserProgressVM = CoreDataUserProgressVM()
    @StateObject private var coreDataJournalVM: CoreDataJournalVM = CoreDataJournalVM()
    @StateObject private var coreDataSearchEntityVM: CoreDataSearchEntityVM = CoreDataSearchEntityVM()
    
    @State private var tabComponentEnum: TabComponentEnum = .home
    
    var body: some View {
        VStack {
            tabComponentEnum.tabView
                .environmentObject(coreDataUserProgressVM)
                .environmentObject(coreDataJournalVM)
                .environmentObject(coreDataSearchEntityVM)
                .padding(.top, getSafeArea().top)
            TabBarNavigationComponent(selectedTabComponentEnum: $tabComponentEnum)
                .padding(.horizontal)
                .padding(.bottom, getSafeArea().bottom + 5)
        }
        .frame(height: UIScreen.main.bounds.height)
        .background(isLightTheme ? LinearGradientEnum.mainScreenBg.linearGradientColors : LinearGradientEnum.darkBackgorund.linearGradientColors)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    RootTabView()
}
