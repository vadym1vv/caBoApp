//
//  CultureLessonsView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

struct CultureLessonsView: View {
    
    @EnvironmentObject private var coreDataUserProgressVM: CoreDataUserProgressVM
    
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var navigateToCultureLessonView: Bool = false
    @State private var cultureLessonToNavigate: CultureModel? = nil
    
    
    
    private let cultureLessonsModels: [CultureModel] = GlobalConstant.cultureLessons
    
    var body: some View {
        VStack {
            NavigationLink(isActive: $navigateToCultureLessonView) {
                if let cultureLessonToNavigate {
                    SingleCultureLessonView(cultureModel: cultureLessonToNavigate)
                        .environmentObject(coreDataUserProgressVM)
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
                        Text("Culture lessons")
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
                    ForEach(cultureLessonsModels) { cultureLesson in
                        SingleRowCardComponent(itemName: cultureLesson.title, itemDescription: cultureLesson.facts, itemImg: cultureLesson.image, background: .colC4E9E1) {
                            cultureLessonToNavigate = cultureLesson
                            withAnimation {
                                navigateToCultureLessonView = true
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

struct CultureLessonsView_Previews: PreviewProvider {
    static var previews: some View {
        CultureLessonsView()
            .environmentObject(CoreDataUserProgressVM())
    }
}
