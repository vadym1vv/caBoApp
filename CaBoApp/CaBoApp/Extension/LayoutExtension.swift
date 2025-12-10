//
//  LayoutExtension.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 10.12.2025.
//

import SwiftUI

extension View {
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
}


