//
//  Cocktails.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

struct CocktailsView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @EnvironmentObject private var coreDataUserProgressVM: CoreDataUserProgressVM
    @EnvironmentObject private var coreDataJournalVM: CoreDataJournalVM
    
    @AppStorage("isLightTheme") private var isLightTheme: Bool = true
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    private let cocktailsModels: [CocktailModel] = GlobalConstant.cocktailsModels
    
    var body: some View {
        VStack {
            TopBarNavigationComponent(
                leadingView:
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {HStack {
                        Image(IconEnum.backBtn.icon)
                        Text("Cocktails")
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
                        ForEach(cocktailsModels) { cocktailModel in
                            NavigationLink {
                                SingleCocktailView(coreDataUserProgressVM: coreDataUserProgressVM, coreDataJournalVM: coreDataJournalVM, cocktailModel: cocktailModel)
                                    .environmentObject(coreDataUserProgressVM)
                            } label: {
                                DoubleRowCardComponent(coreDataUserProgressVM: coreDataUserProgressVM, itemName: cocktailModel.title, itemDescription: cocktailModel.facts, itemImg: cocktailModel.image, categoryEnum: .coctails)
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

struct Cocktails_Previews: PreviewProvider {
    static var previews: some View {
        CocktailsView()
            .environmentObject(CoreDataUserProgressVM())
            .environmentObject(CoreDataJournalVM())
    }
}
