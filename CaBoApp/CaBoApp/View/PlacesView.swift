
import SwiftUI

struct PlacesView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @EnvironmentObject private var coreDataUserProgressVM: CoreDataUserProgressVM
    @EnvironmentObject private var coreDataJournalVM: CoreDataJournalVM
    
    @AppStorage("isLightTheme") private var isLightTheme: Bool = true
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    private let placesModel: [PlacesModel] = GlobalConstant.placesModels
    
    var body: some View {
        VStack {
            TopBarNavigationComponent(
                leadingView:
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {HStack {
                        Image(IconEnum.backBtn.icon)
                        Text("Places")
                            .font(FontEnum.joSaBold24.font)
                            .foregroundColor(isLightTheme ? ColorEnum.col181818.color : ColorEnum.colFFFFFF.color)
                    }
                    },
                centerView:
                    EmptyView(),
                trailingView:
                    EmptyView())
            ScrollView {
                VStack {
                    LazyVGrid(columns: columns) {
                        ForEach(placesModel) { placeModel in
                            NavigationLink {
                                SinglePlaceView(coreDataUserProgressVM: coreDataUserProgressVM, coreDataJournalVM: coreDataJournalVM, placeModel: placeModel)
                                    .environmentObject(coreDataUserProgressVM)
                            } label: {
                                DoubleRowCardComponent(coreDataUserProgressVM: coreDataUserProgressVM, itemName: placeModel.title, itemDescription: placeModel.facts, itemImg: placeModel.image, categoryEnum: .places)
                            }   
                        }
                    }
                }
                .padding(.horizontal)
            }
            
        }
        .padding(.top, getSafeArea().top)
        .background(isLightTheme ? LinearGradientEnum.mainScreenBg.linearGradientColors : LinearGradientEnum.darkBackgorund.linearGradientColors)
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlacesView()
                .environmentObject(CoreDataUserProgressVM())
                .environmentObject(CoreDataJournalVM())
        }
    }
}
