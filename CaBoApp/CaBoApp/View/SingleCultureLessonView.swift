//
//  SingleCultureLessonView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

struct SingleCultureLessonView: View {
    
    let cultureModel: CultureModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SingleCultureLessonView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCultureLessonView(cultureModel: GlobalConstant.cultureLessons[0])
    }
}
