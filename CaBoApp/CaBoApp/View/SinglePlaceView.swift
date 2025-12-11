//
//  SinglePlaceView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

struct SinglePlaceView: View {
    
    let placeModel: PlacesModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SinglePlaceView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePlaceView(placeModel: GlobalConstant.placesModels[0])
    }
}
