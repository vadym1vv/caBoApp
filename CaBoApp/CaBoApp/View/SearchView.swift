//
//  SearchView.swift
//  CaBoApp
//
//  Created by Vadym Vasylaki on 15.12.2025.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var coreDataSearchEntityVM: CoreDataSearchEntityVM = CoreDataSearchEntityVM()
    
    @State private var searchInput: String? = nil
    @State private var typeCategory: CategoryEnum? = nil
    @State private var moodEnum: MoodEnum? = nil
    @State private var difficultyEnum: DifficultyEnum? = nil
    @State private var timeForSession: TimeForSessionEnum? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: UIScreen.main.bounds.height / 50) {
            
                Text("Search")
                    .font(FontEnum.joSaBold24.font)
                
            HStack {
                Image(IconEnum.searchFieldIcon.icon)
                    .padding(.leading)
                TextField("Cocktails, lessons, places, sessions...", text: Binding(get: {
                        searchInput ?? ""
                    }, set: { newValue in
                        searchInput = newValue
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
                        if (self.typeCategory == category) {
                            self.typeCategory = nil
                        } else {
                            self.typeCategory = category
                        }
                    } label: {
                        VStack {
                            Image(category.iconButton)
                                .opacity(category == typeCategory ? 0.3 : 1)
                            Text(category.rawValue.capitalized)
                                .font(FontEnum.joSaRegular16.font)
                                .foregroundColor(ColorEnum.col181818.color)
                                .opacity(category == typeCategory ? 0.5 : 1)
                        }
                    }
                    .padding(5)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            Text("Mood")
            HStack {
                ForEach(MoodEnum.allCases) { mood in
                    Button {
                        if (moodEnum == mood) {
                            moodEnum = nil
                        } else {
                            moodEnum = mood
                        }
                      
                    } label: {
                        Text(mood.rawValue.capitalized)
                            .font(FontEnum.joSaMedium14.font)
                            .frame(height: UIScreen.main.bounds.height / 25)
                            .frame(maxWidth: .infinity)
                            .background(moodEnum == mood ? ColorEnum.colC4C4C4.color : ColorEnum.colFFFFFF.color)
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
                        if (difficulty == difficultyEnum) {
                            difficultyEnum = nil
                        } else {
                            self.difficultyEnum = difficulty
                        }
                        
                    } label: {
                        HStack {
                            difficulty.difficultyStars
                            Text(difficulty.rawValue.capitalized)
                                .font(FontEnum.joSaMedium14.font)
                                .frame(height: UIScreen.main.bounds.height / 25)
                                
                               
                               
                        }
//                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 8)
                        .background(difficultyEnum == difficulty ? ColorEnum.colC4C4C4.color : ColorEnum.colFFFFFF.color)
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
                        if (self.timeForSession == timeForSession) {
                            self.timeForSession = nil
                        } else {
                            self.timeForSession = timeForSession
                        }
                        
                    } label: {
                        HStack {
                            Image(IconEnum.timeNeededIcon.icon)
                            Text(timeForSession.rawValue)
                                .font(FontEnum.joSaMedium14.font)
                                .frame(height: UIScreen.main.bounds.height / 25)
                                
                        }
                        .padding(.horizontal, 8)
                        .background(self.timeForSession == timeForSession ? ColorEnum.colC4C4C4.color : ColorEnum.colFFFFFF.color)
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
                    Button {
                        searchInput = searchRequest.searchString
                        
                        if let type = searchRequest.typeCategory, let typeEnum = CategoryEnum(rawValue: type) {
                            typeCategory = typeEnum
                        }
                        
                        if let mood = searchRequest.mood, let moodEnum = MoodEnum(rawValue: mood) {
                            self.moodEnum = moodEnum
                        }
                        
                        if let difficulty = searchRequest.difficulty, let difficultyEnum = DifficultyEnum(rawValue: difficulty) {
                            self.difficultyEnum = difficultyEnum
                        }
                        
                        if let timeNeeded = searchRequest.timeNeeded, let timeEnum  = TimeForSessionEnum(rawValue: timeNeeded) {
                            timeForSession = timeEnum
                        }
                    } label: {
                        HStack {
                            Image(IconEnum.timeNeededIcon.icon)
                            Text(searchRequest.searchString ?? searchRequest.typeCategory?.capitalized ?? searchRequest.mood?.capitalized ?? searchRequest.difficulty?.capitalized ?? "")
                        }
                        .frame(maxHeight: .infinity)
                    }
                    Button {
                        coreDataSearchEntityVM.deleteSearchRequest(searchEntity: searchRequest)
                    } label: {
                        Image(IconEnum.deleteIcon.icon)
                    }

                }
                .background(ColorEnum.colFFC8AF.color)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            }
            
            Button {
                coreDataSearchEntityVM.updateItem(searchRequest: searchInput, type: typeCategory?.rawValue, mood: moodEnum?.rawValue, difficulty: difficultyEnum?.rawValue, timeNeeded: timeForSession?.rawValue)
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
                    searchInput = nil
                    typeCategory = nil
                    moodEnum = nil
                    difficultyEnum = nil
                    timeForSession = nil
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
