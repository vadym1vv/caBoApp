//
//  JourneyComponent.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

struct JourneyComponent: View {
    
    @StateObject private var manager = JourneyManager()
    @State private var navigateToNextJourney: Bool = false
    
    var body: some View {
        HStack {
            NavigationLink(isActive: $navigateToNextJourney) {
                JourneyDetailView(manager: manager)
            } label: {
                EmptyView()
            }

            VStack(alignment: .leading) {
                Text("Your Cuban journey")
                    .font(FontEnum.joSaSemibold20.font)
                HStack {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: UIScreen.main.bounds.width / 2 - 60)
                            .foregroundColor(ColorEnum.col47338F30.color)
                            
                        
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: manager.readProgressWidth)
                            .foregroundColor(ColorEnum.col47338F.color)
                    }
                    .frame(height: 9)
                    .frame(width: UIScreen.main.bounds.width / 2 - 70)
                    Text("\(manager.currentPrecentProgress)%")
                        .font(FontEnum.joSaSemibold16.font)
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

                Button {
                    navigateToNextJourney = true
                    manager.next()
                } label: {
                    Text("Start session")
                        .padding(.horizontal)
                        .font(FontEnum.joSaSemibold16.font)
                        .frame(height: 44)
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
    }
}
struct JourneyComponent_Previews: PreviewProvider {
    static var previews: some View {
        JourneyComponent()
            .padding(.horizontal)
    }
}


struct JourneyDetailView: View {
    @ObservedObject var manager: JourneyManager
    
    var body: some View {
        Group {
            switch manager.currentType {
            case .cocktails:
                if let model = manager.currentCocktail {
                    SingleCocktailView(coctailModel: model)
                } else {
                    EmptyView()
                }
                
            case .culture:
                if let model = manager.currentCulture {
                    SingleCultureLessonView(cultureModel: model)
                }
                
            case .places:
                if let model = manager.currentPlace {
                    SinglePlaceView(placeModel: model)
                } else {
                    EmptyView()
                }
                
            case .homeSessions:
                if let model = manager.currentSession {
                    SingleHomeSessionView(homeSessionModel: model)
                } else {
                    EmptyView()
                }
            }
        }
//         .navigationTitle(manager.currentType.title)
    }
}
