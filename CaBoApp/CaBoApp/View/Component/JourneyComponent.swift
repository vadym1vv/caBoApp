
import SwiftUI

struct JourneyComponent: View {
    
    @ObservedObject var coreDataUserProgressVM: CoreDataUserProgressVM
    @ObservedObject var coreDataJournalVM: CoreDataJournalVM
    
    @StateObject private var manager = JourneyManager()
    @State private var navigateToNextJourney: Bool = false
    
    var body: some View {
        HStack {
            NavigationLink(isActive: $navigateToNextJourney) {
                JourneyDetailView(manager: manager, coreDataUserProgressVM: coreDataUserProgressVM, coreDataJournalVM: coreDataJournalVM)
                    .environmentObject(coreDataUserProgressVM)
            } label: {
                EmptyView()
            }
            
            VStack(alignment: .leading) {
                Text("Your Cuban journey")
                    .font(FontEnum.joSaSemibold20.font)
                HStack {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: UIScreen.main.bounds.width / 2.5 - 60)
                            .foregroundColor(ColorEnum.col47338F30.color)
                        
                        
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: manager.readProgressWidth)
                            .foregroundColor(ColorEnum.col47338F.color)
                    }
                    .frame(height: 9)
                    .frame(width: UIScreen.main.bounds.width / 2.5 - 60)
                    Text("\(manager.currentPrecentProgress)%")
                        .font(FontEnum.joSaSemibold16.font)
                        .padding(.trailing)
                }
                .padding(.bottom)
                Text("Next step:\n‘Havana Sunrise Spritz’")
                    .font(FontEnum.joSaRegular16.font)
                    .multilineTextAlignment(.leading)
                    .padding(.top)
            }
            .padding([.vertical, .leading], 10)
            Spacer()
            VStack {
                Image(IconEnum.startSessionImg.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.height / 10, height: UIScreen.main.bounds.height / 10)
                Button {
                    navigateToNextJourney = true
                    manager.next()
                } label: {
                    Text("Start session")
                        .padding(.horizontal)
                        .font(FontEnum.joSaSemibold16.font)
                        .frame(height: UIScreen.main.bounds.height / 25)
                        .background(ColorEnum.colFFFFFF.color)
                        .foregroundColor(ColorEnum.col181818.color)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding([.vertical, .trailing])
        }
        .frame(maxWidth: .infinity)
        .background(ColorEnum.col7443FF.color)
        .foregroundColor(ColorEnum.colFFFFFF.color)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onAppear {
            manager.resetState()
        }
    }
}
struct JourneyComponent_Previews: PreviewProvider {
    static var previews: some View {
        JourneyComponent(coreDataUserProgressVM: CoreDataUserProgressVM(), coreDataJournalVM: CoreDataJournalVM())
            .padding(.horizontal)
            .environmentObject(CoreDataUserProgressVM())
    }
}


struct JourneyDetailView: View {
    @ObservedObject var manager: JourneyManager
    @ObservedObject var coreDataUserProgressVM: CoreDataUserProgressVM
    @ObservedObject var coreDataJournalVM: CoreDataJournalVM
    var body: some View {
        Group {
            switch manager.currentType {
            case .cocktails:
                if let model = manager.currentCocktail {
                    SingleCocktailView(coreDataUserProgressVM: coreDataUserProgressVM, coreDataJournalVM: coreDataJournalVM, cocktailModel: model)
                } else {
                    EmptyView()
                }
                
            case .culture:
                if let model = manager.currentCulture {
                    SingleCultureLessonView(coreDataUserProgressVM: coreDataUserProgressVM, coreDataJournalVM: coreDataJournalVM,cultureModel: model)
                }
                
            case .places:
                if let model = manager.currentPlace {
                    SinglePlaceView(coreDataUserProgressVM: coreDataUserProgressVM, coreDataJournalVM: coreDataJournalVM,placeModel: model)
                } else {
                    EmptyView()
                }
                
            case .homeSessions:
                if let model = manager.currentSession {
                    SingleHomeSessionView(coreDataUserProgressVM: coreDataUserProgressVM, coreDataJournalVM: coreDataJournalVM,homeSessionModel: model)
                } else {
                    EmptyView()
                }
            }
        }
    }
}
