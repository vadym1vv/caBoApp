//
//  HomeSessionsView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

struct HomeSessionsView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @EnvironmentObject private var coreDataUserProgressVM: CoreDataUserProgressVM
    @EnvironmentObject var coreDataJournalVM: CoreDataJournalVM
    
    @State private var navigateToHomeSession: Bool = false
    @State private var homeSessionToNavigate: HomeSessionModel? = nil
    
    
    
    private let placesModel: [HomeSessionModel] = GlobalConstant.homeSessionsModels
    
    var body: some View {
        VStack {
            NavigationLink(isActive: $navigateToHomeSession) {
                if let homeSessionToNavigate {
                    SingleHomeSessionView(coreDataUserProgressVM: coreDataUserProgressVM, coreDataJournalVM: coreDataJournalVM, homeSessionModel: homeSessionToNavigate)
                }
            } label: {
                EmptyView()
            }

            TopBarNavigationComponent(
                leadingView:
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {HStack {
                        Image(IconEnum.backBtn.icon)
                        Text("Home sessions")
                            .font(FontEnum.joSaBold24.font)
                            .foregroundColor(ColorEnum.col181818.color)
                    }
                    },
                centerView:
                    EmptyView(),
                trailingView:
                    EmptyView())
            ScrollView {
                VStack {
                    ForEach(placesModel) { homeSessionModel in
                        SingleRowCardComponent(coreDataUserProgressVM: coreDataUserProgressVM, itemName: homeSessionModel.title, itemDescription: homeSessionModel.timeForSession.longDescription, itemImg: homeSessionModel.image, background: .colEDE7FA, categoryEnum: CategoryEnum.homeSessions, showMinutesIcon: true) {
                            homeSessionToNavigate = homeSessionModel
                            withAnimation {
                                navigateToHomeSession = true
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            
        }
        .padding(.top, getSafeArea().top)
        .background(LinearGradientEnum.mainScreenBg.linearGradientColors)
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct HomeSessionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeSessionsView()
                .environmentObject(CoreDataUserProgressVM())
                .environmentObject(CoreDataJournalVM())
        }
    }
}
