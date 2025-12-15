//
//  TabComponentEnum.swift
//  CaBoApp
//
//  Created by Vadym Vasylaki on 15.12.2025.
//

import SwiftUI

enum TabComponentEnum: String, CaseIterable, Identifiable {
    var id: Self {self}
    case home, search, favorites, history, stat
    
    @ViewBuilder
    var tabView: some View {
        switch self {
        case .home:
            MainScreenView()
        case .search:
            SearchView()
        case .favorites:
            FavoritesView()
        case .history:
            HistoryView()
        case .stat:
            StatView()
        }
    }
    
    var tabIcon: String {
        switch self {
        case .home:
            IconEnum.homeCategory.icon
        case .search:
            IconEnum.searchCategory.icon
        case .favorites:
            IconEnum.favoritesCategory.icon
        case .history:
            IconEnum.historyCategory.icon
        case .stat:
            IconEnum.statCategory.icon
        }
    }
}
