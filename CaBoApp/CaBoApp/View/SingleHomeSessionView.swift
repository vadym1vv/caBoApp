//
//  SingleHomeSessionView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

struct SingleHomeSessionView: View {
    
    let homeSessionModel: HomeSessionModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SingleHomeSessionView_Previews: PreviewProvider {
    static var previews: some View {
        SingleHomeSessionView(homeSessionModel: GlobalConstant.homeSessionsModels[0])
    }
}
