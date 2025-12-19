
import SwiftUI

struct ItemDetailsCardComponent: View {
    
    let icon: IconEnum
    let title: String
    let bodyText: String
    let background: ColorEnum
    let borderColor: ColorEnum
    let iconForegroundColor: ColorEnum
    
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 13)
                    .foregroundColor(borderColor.color)
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(icon.icon)
                                .renderingMode(.template)
                                .foregroundColor(iconForegroundColor.color)
                            Text(title)
                                .font(FontEnum.joSaItalic20.font)
                        }
                        Text(bodyText)
                    }
                    Spacer()
                }
                .padding()
                .background(background.color)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(1)
                
            }
            Spacer()
        }
        .foregroundColor(ColorEnum.col181818.color)
        .font(FontEnum.joSaRegular16.font)
    }
}

#Preview {
    ScrollView {
        ItemDetailsCardComponent(icon: IconEnum.cocktailListImage, title: "Origin", bodyText: "This cocktail is a modern interpretation inspired by the classic Tequila Sunrise, but adapted to Cuban culture and rum tradition.", background: .colFFC8AF, borderColor: .colFF5D4D, iconForegroundColor: .colFF6F61)
    }
}
