//
//  SearchView.swift
//  CaBoApp
//
//  Created by Vadym Vasylaki on 15.12.2025.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var coreDataSearchEntityVM: CoreDataSearchEntityVM = CoreDataSearchEntityVM()
    
    @EnvironmentObject private var coreDataUserProgressVM: CoreDataUserProgressVM
    
    @StateObject private var searchVM: SearchVM = SearchVM()
    @State private var performNavigationToSearchResults: Bool = false
    @State private var searchResults: [any CategoryProtocol] = []
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            NavigationLink(isActive: $performNavigationToSearchResults) {
                SearchResultView(coreDataUserProgressVM: coreDataUserProgressVM, searchResults: searchResults)
            } label: {
                EmptyView()
            }
            
            VStack(alignment: .leading, spacing: UIScreen.main.bounds.height / 50) {
                
                Text("Search")
                    .font(FontEnum.joSaBold24.font)
                
                HStack {
                    Image(IconEnum.searchFieldIcon.icon)
                        .padding(.leading)
                    TextField("Cocktails, lessons, places, sessions...", text: Binding(get: {
                        searchVM.searchInput ?? ""
                    }, set: { newValue in
                        searchVM.searchInput = newValue
                    }))
                    .font(FontEnum.joSaRegular16.font)
                    .padding(.trailing, 3)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(ColorEnum.colFFFFFF.color)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text("Type")
                HStack {
                    Spacer()
                    ForEach(CategoryEnum.allCases) { category in
                        Button {
                            if (searchVM.typeCategory == category) {
                                searchVM.typeCategory = nil
                            } else {
                                searchVM.typeCategory = category
                            }
                        } label: {
                            VStack {
                                Image(category.iconButton)
                                    .opacity(category == searchVM.typeCategory ? 0.3 : 1)
                                Text(category.rawValue.capitalized)
                                    .font(FontEnum.joSaRegular16.font)
                                    .foregroundColor(ColorEnum.col181818.color)
                                    .opacity(category == searchVM.typeCategory ? 0.5 : 1)
                            }
                        }
                        .padding(3)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                Text("Mood")
                HStack {
                    ForEach(MoodEnum.allCases) { mood in
                        Button {
                            if (searchVM.moodEnum == mood) {
                                searchVM.moodEnum = nil
                            } else {
                                searchVM.moodEnum = mood
                            }
                            
                        } label: {
                            Text(mood.rawValue.capitalized)
                                .font(FontEnum.joSaMedium14.font)
                                .frame(height: UIScreen.main.bounds.height / 25)
                                .frame(maxWidth: .infinity)
                                .background(searchVM.moodEnum == mood ? ColorEnum.colC4C4C4.color : ColorEnum.colFFFFFF.color)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Difficulty")
                    Text("(for cocktails and sessions)")
                        .font(FontEnum.joSaLight16.font)
                }
                HStack {
                    ForEach(DifficultyEnum.allCases) { difficulty in
                        Button {
                            if (difficulty == searchVM.difficultyEnum) {
                                searchVM.difficultyEnum = nil
                            } else {
                                searchVM.difficultyEnum = difficulty
                            }
                            
                        } label: {
                            HStack {
                                difficulty.difficultyStars
                                Text(difficulty.rawValue.capitalized)
                                    .font(FontEnum.joSaMedium14.font)
                                    .frame(height: UIScreen.main.bounds.height / 25)
                                
                                
                                
                            }
                            
                            .padding(.horizontal, 8)
                            .background(searchVM.difficultyEnum == difficulty ? ColorEnum.colC4C4C4.color : ColorEnum.colFFFFFF.color)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                        }
                    }
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Time needed")
                    Text("(for sessions)")
                        .font(FontEnum.joSaLight16.font)
                }
                HStack {
                    ForEach(TimeForSessionEnum.timeForFilter) { timeForSession in
                        Button {
                            if (searchVM.timeForSession == timeForSession) {
                                searchVM.timeForSession = nil
                            } else {
                                searchVM.timeForSession = timeForSession
                            }
                            
                        } label: {
                            HStack {
                                Image(IconEnum.timeNeededIcon.icon)
                                Text(timeForSession.rawValue)
                                    .font(FontEnum.joSaMedium14.font)
                                    .frame(height: UIScreen.main.bounds.height / 25)
                                
                            }
                            .padding(.horizontal, 8)
                            .background(searchVM.timeForSession == timeForSession ? ColorEnum.colC4C4C4.color : ColorEnum.colFFFFFF.color)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
                .padding(.horizontal)
                
                Text("Recent searches")
                ForEach(
                    coreDataSearchEntityVM.searchRequests
                        .sorted {
                            ($0.searchDate ?? .distantPast) > ($1.searchDate ?? .distantPast)
                        }
                        .prefix(2),
                    id: \.self
                ) { searchRequest in
                    HStack {
                        HStack {
                            Button {
                                searchVM.searchInput = searchRequest.searchString
                                
                                if let type = searchRequest.typeCategory, let typeEnum = CategoryEnum(rawValue: type) {
                                    searchVM.typeCategory = typeEnum
                                }
                                
                                if let mood = searchRequest.mood, let moodEnum = MoodEnum(rawValue: mood) {
                                    searchVM.moodEnum = moodEnum
                                }
                                
                                if let difficulty = searchRequest.difficulty, let difficultyEnum = DifficultyEnum(rawValue: difficulty) {
                                    searchVM.difficultyEnum = difficultyEnum
                                }
                                
                                if let timeNeeded = searchRequest.timeNeeded, let timeEnum  = TimeForSessionEnum(rawValue: timeNeeded) {
                                    searchVM.timeForSession = timeEnum
                                }
                            } label: {
                                HStack {
                                    Image(IconEnum.timeNeededIcon.icon)
                                    Text(searchRequest.searchString ?? searchRequest.typeCategory?.capitalized ?? searchRequest.mood?.capitalized ?? searchRequest.difficulty?.capitalized ?? "")
                                    Spacer()
                                }
                            }
                            .padding(.leading)
                            
                        }
                        .frame(maxWidth: UIScreen.main.bounds.width - 44)
                        Button {
                            coreDataSearchEntityVM.deleteSearchRequest(searchEntity: searchRequest)
                        } label: {
                            Image(IconEnum.deleteIcon.icon)
                                .frame(width: 12)
                                .padding(.trailing)
                        }
                        
                    }
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
                    .background(ColorEnum.colFFC8AF.color)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                }
                
                Button {
                    coreDataSearchEntityVM.updateItem(searchRequest: searchVM.searchInput, type: searchVM.typeCategory?.rawValue, mood: searchVM.moodEnum?.rawValue, difficulty: searchVM.difficultyEnum?.rawValue, timeNeeded: searchVM.timeForSession?.rawValue)
                    searchResults = searchVM.performSearch()
                    performNavigationToSearchResults = true
                } label: {
                    Text("Apply")
                        .foregroundColor(ColorEnum.colFFFFFF.color)
                        .frame(height: 44)
                        .frame(maxWidth: .infinity)
                        .background(ColorEnum.colFF6F61.color)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                }
                .padding(.horizontal)
                
                Button {
                    withAnimation {
                        searchVM.resetSearchCriteria()
                    }
                } label: {
                    Text("Reset filters")
                        .frame(height: 44)
                        .frame(maxWidth: .infinity)
                        .background(ColorEnum.colFFFFFF.color)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .foregroundColor(ColorEnum.col181818.color)
            .font(FontEnum.joSaMedium20.font)
            .padding(.horizontal)
        }
    }
}

#Preview {
    VStack {
        VStack {
            SearchView()
        }
        .padding(.horizontal)
    }
    .frame(maxHeight: .infinity)
    .background(LinearGradientEnum.mainScreenBg.linearGradientColors)
}
