
import SwiftUI

struct SingleRowCardComponent: View {
    
    @ObservedObject var coreDataUserProgressVM: CoreDataUserProgressVM
    
    let itemName: String
    let itemDescription: String
    let itemImg: String
    var background: ColorEnum
    let categoryEnum: CategoryEnum
    var showMinutesIcon: Bool = false
    var navigateAction: () -> ()
    
    var isFavoriteIcon: String {
        coreDataUserProgressVM.items.contains(where: {$0.isFavorite && $0.itemName == itemName}) ? IconEnum.favIconOn.icon : IconEnum.favIconOff.icon
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(itemImg)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width / 4)
                    .frame(height: UIScreen.main.bounds.height / 5)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(itemName)
                                .font(FontEnum.joSaBold18.font)
                                .padding(.vertical, 11)
                                .lineLimit(2)
                            HStack {
                                if (showMinutesIcon) {
                                    Image(IconEnum.timeNeededIcon.icon)
                                }
                                Text(itemDescription)
                                    .font(FontEnum.joSaItalic16.font)
                                    .lineLimit(2)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        Button {
                            coreDataUserProgressVM.updateFavoriteItem(itemName: itemName, categoryEnum: categoryEnum.rawValue, toggleFavorite: true)
                        } label: {
                            Image(isFavoriteIcon)
                        }
                        .padding([.trailing, .top], 5)
                    }
                    Spacer()
                    Button {
                        navigateAction()
                    } label: {
                        Text("See more details")
                            .font(FontEnum.joSaMedium16.font)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(LinearGradientEnum.onboardingBtnBg.linearGradientColors)
                            .foregroundColor(ColorEnum.colFFFFFF.color)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                    }
                }
                .padding(.leading, 8)
            }
            .padding(8)
        }
        .background(background.color)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct SingleRowCardComponent_Previews: PreviewProvider {
    static var previews: some View {
        SingleRowCardComponent(coreDataUserProgressVM: CoreDataUserProgressVM(), itemName: "Malecón", itemDescription: "Mint, lime, and the rhythm of the waves", itemImg: IconEnum.malecónLoversBench.icon, background: ColorEnum.colC4E9E1, categoryEnum: CategoryEnum.coctails, navigateAction: {})
            .padding()
        
    }
}
