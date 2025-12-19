
import SwiftUI

enum FontEnum: CaseIterable {
    
    case daScRegular24, daScMedium30
    case joSaLight16
    case joSaLRegular18, joSaRegular20, joSaRegular16, joSaRegular14
    case joSaMedium20, joSaMedium18, joSaMedium16, joSaMedium14
    case joSaSemibold20, joSaSemibold18, joSaSemibold16
    case joSaBold24, joSaBold18, joSaBold16
    case joSaItalic16, joSaItalic20
    
    var font: Font {
        switch self {
        case .daScRegular24:
            return Font.custom("DancingScript-Regular", size: 24)
        case .daScMedium30:
            return Font.custom("DancingScript-Medium", size: 30)
        case .joSaLight16:
            return Font.custom("JosefinSans-Light", size: 16)
        case .joSaLRegular18:
            return Font.custom("JosefinSans-Regular", size: 18)
        case .joSaRegular20:
            return Font.custom("JosefinSans-Regular", size: 20)
        case .joSaRegular16:
            return Font.custom("JosefinSans-Regular", size: 16)
        case .joSaRegular14:
            return Font.custom("JosefinSans-Regular", size: 14)
        case .joSaMedium20:
            return Font.custom("JosefinSans-Medium", size: 20)
        case .joSaMedium18:
            return Font.custom("JosefinSans-Medium", size: 18)
        case .joSaMedium16:
            return Font.custom("JosefinSans-Medium", size: 16)
        case .joSaMedium14:
            return Font.custom("JosefinSans-Medium", size: 14)
        case .joSaSemibold20:
            return Font.custom("JosefinSans-SemiBold", size: 20)
        case .joSaSemibold18:
            return Font.custom("JosefinSans-SemiBold", size: 18)
        case .joSaSemibold16:
            return Font.custom("JosefinSans-SemiBold", size: 16)
        case .joSaBold24:
            return Font.custom("JosefinSans-Bold", size: 24)
        case .joSaBold18:
            return Font.custom("JosefinSans-Bold", size: 18)
        case .joSaBold16:
            return Font.custom("JosefinSans-Bold", size: 16)
        case .joSaItalic16:
            return Font.custom("JosefinSans-Italic", size: 16)
        case .joSaItalic20:
            return Font.custom("JosefinSans-Italic", size: 20)
        }
    }
}

struct FontEnum_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ScrollView {
                ForEach(FontEnum.allCases, id: \.self) { font in
                    Text("Hello world")
                        .font(font.font)
                }
            }
        }
    }
}
