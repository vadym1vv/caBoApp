
import SwiftUI

struct DoubleRowCardComponent: View {
    
    @ObservedObject var coreDataUserProgressVM: CoreDataUserProgressVM
    
    let itemName: String
    let itemDescription: String
    let itemImg: String
    let categoryEnum: CategoryEnum
    
    
    var isFavoriteIcon: String {
        coreDataUserProgressVM.items.contains(where: {$0.isFavorite && $0.itemName == itemName}) ? IconEnum.favIconOn.icon : IconEnum.favIconOff.icon
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                ZStack(alignment: .topTrailing) {
                    Image(itemImg)
                        .resizable()
                        .scaledToFill()
                        .frame(height: UIScreen.main.bounds.height / 5)
                    Button {
                        coreDataUserProgressVM.updateFavoriteItem(itemName: itemName, categoryEnum: categoryEnum.rawValue, toggleFavorite: true)
                    } label: {
                        Image(isFavoriteIcon)
                    }
                    .padding(10)
                    .padding(.top, 5)
                }
                
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text(itemName)
                    .font(FontEnum.joSaBold18.font)
                    .lineLimit(2)
                Text(itemDescription)
                    .font(FontEnum.joSaItalic16.font)
                    .lineLimit(2)
            }
            .padding(5)
        }
        .background(ColorEnum.colFFC8AF.color)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .foregroundColor(ColorEnum.col181818.color)
        .multilineTextAlignment(.leading)
    }
}

struct DoubleRowCardComponent_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            HStack {
                DoubleRowCardComponent(coreDataUserProgressVM: CoreDataUserProgressVM(), itemName: "Malecón Mojito Night", itemDescription: "Mint, lime, and the rhythm of the waves", itemImg: IconEnum.malecónLoversBench.icon, categoryEnum: CategoryEnum.coctails)
                DoubleRowCardComponent(coreDataUserProgressVM: CoreDataUserProgressVM(), itemName: "Malecón Mojito Night", itemDescription: "Mint, lime, and the rhythm of the waves", itemImg: IconEnum.malecónLoversBench.icon, categoryEnum: CategoryEnum.coctails)
            }
            .padding(.horizontal)
            
        }
    }
}
