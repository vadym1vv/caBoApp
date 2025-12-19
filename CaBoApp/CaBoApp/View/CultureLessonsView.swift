
import SwiftUI

struct CultureLessonsView: View {
    
    @EnvironmentObject private var coreDataUserProgressVM: CoreDataUserProgressVM
    @EnvironmentObject private var coreDataJournalVM: CoreDataJournalVM
    
    @Environment(\.presentationMode) private var presentationMode
    
    @AppStorage("isLightTheme") private var isLightTheme: Bool = true
    
    @State private var navigateToCultureLessonView: Bool = false
    @State private var cultureLessonToNavigate: CultureModel? = nil
    
    private let cultureLessonsModels: [CultureModel] = GlobalConstant.cultureLessons
    
    var body: some View {
        VStack {
            NavigationLink(isActive: $navigateToCultureLessonView) {
                if let cultureLessonToNavigate {
                    SingleCultureLessonView(coreDataUserProgressVM: coreDataUserProgressVM, coreDataJournalVM: coreDataJournalVM, cultureModel: cultureLessonToNavigate)
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
                            .foregroundColor(isLightTheme ? ColorEnum.col181818.color : ColorEnum.colFFFFFF.color)
                    }
                    },
                centerView:
                    EmptyView(),
                trailingView:
                    EmptyView())
            ScrollView {
                VStack {
                    ForEach(cultureLessonsModels) { cultureLesson in
                        SingleRowCardComponent(coreDataUserProgressVM: coreDataUserProgressVM, itemName: cultureLesson.title, itemDescription: cultureLesson.facts, itemImg: cultureLesson.image, background: .colC4E9E1, categoryEnum: CategoryEnum.cultureLessons) {
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
        .background(isLightTheme ? LinearGradientEnum.mainScreenBg.linearGradientColors : LinearGradientEnum.darkBackgorund.linearGradientColors)
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct CultureLessonsView_Previews: PreviewProvider {
    static var previews: some View {
        CultureLessonsView()
            .environmentObject(CoreDataUserProgressVM())
            .environmentObject(CoreDataJournalVM())
    }
}
