
import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject private var coreDataJournalVM: CoreDataJournalVM
    
    @State private var selectedCategory: [CategoryEnum] = CategoryEnum.allCases
    
    @AppStorage("isLightTheme") private var isLightTheme: Bool = true
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var sortedItems: [JournalItemEntity] {
        
        return coreDataJournalVM.journalItemEntities.filter { journalEntity in
            return selectedCategory.contains(where: {$0.rawValue == journalEntity.itemCategory})
        }
    }
    
    var groupedItems: [(key: String, value: [JournalItemEntity])] {
        
        let grouped = Dictionary(grouping: sortedItems) { (entity: JournalItemEntity) -> Date in
            Calendar.current.startOfDay(for: entity.date ?? Date())
        }
        
        let sortedDates = grouped.keys.sorted(by: >)
        
        return sortedDates.map { date in
            
            let header: String
            if Calendar.current.isDateInToday(date) {
                header = "Today"
            } else if Calendar.current.isDateInYesterday(date) {
                header = "Yesterday"
            } else {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd MMM yyyy"
                header = formatter.string(from: date)
            }
            
            let itemsForDay = grouped[date] ?? []
            let sortedItemsForDay = itemsForDay.sorted {
                ($0.date ?? Date()) > ($1.date ?? Date())
            }
            
            return (header, sortedItemsForDay)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Journal")
                    .font(FontEnum.joSaBold24.font)
                    .foregroundColor(isLightTheme ? ColorEnum.col181818.color : ColorEnum.colFFFFFF.color)
                Spacer()
            }
            HStack {
                Button {
                    selectedCategory = []
                    selectedCategory = CategoryEnum.allCases
                } label: {
                    Text("All")
                    //                        .frame(height: 70)
                        .font(FontEnum.joSaMedium14.font)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                        .background(selectedCategory == CategoryEnum.allCases ? ColorEnum.colFFC8AF.color : ColorEnum.colFFFFFF.color)
                    
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                ForEach(CategoryEnum.allCases) { category in
                    Button {
                        if (selectedCategory == CategoryEnum.allCases) {
                            selectedCategory = []
                        }
                        if (selectedCategory.contains(category)) {
                            selectedCategory.removeAll(where: {$0 == category})
                        } else {
                            selectedCategory.append(category)
                        }
                    } label: {
                        Text(category.shortDescription)
                            .font(FontEnum.joSaMedium14.font)
                        //                            .frame(maxHeight: .infinity)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(selectedCategory.contains(where: {$0 == category}) && selectedCategory != CategoryEnum.allCases ? ColorEnum.colFFC8AF.color : ColorEnum.colFFFFFF.color)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.height / 25)
            .frame(maxWidth: .infinity)
            
            if (!groupedItems.isEmpty) {
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(groupedItems, id: \.key) { header, items in
                            
                            Text(header)
                                .foregroundColor(isLightTheme ? ColorEnum.col181818.color : ColorEnum.colFFFFFF.color)
                                .font(FontEnum.joSaBold18.font)
                                .padding(.top, 10)
                            
                            
                            
                            ForEach(items, id: \.self) { journalEntity in
                                if let journalTitle = journalEntity.itemCategory,
                                   let categoryEnum = CategoryEnum(rawValue: journalTitle) {
                                    
                                    VStack {
                                        HStack {
                                            Image(categoryEnum.iconButton)
                                            
                                            VStack(alignment: .leading) {
                                                Text(journalEntity.itemTitle ?? "")
                                                    .font(FontEnum.joSaSemibold16.font)
                                                
                                                Text(categoryEnum.shortDescription)
                                                    .font(FontEnum.joSaMedium14.font)
                                                    .padding(.horizontal, 8)
                                                    .frame(height: UIScreen.main.bounds.height / 25)
                                                    .background(ColorEnum.colFFE0D4.color)
                                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                            }
                                            
                                            Spacer()
                                            
                                            Button {
                                                coreDataJournalVM.deleteJournalEntity(journalEntity: journalEntity)
                                            } label: {
                                                Image(IconEnum.trashIcon.icon)
                                            }
                                        }
                                        .padding()
                                    }
                                    .background(ColorEnum.colFFC8AF.color)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                            }
                        }
                    }
                }
            } else {
                VStack {
                    Image(IconEnum.journalFavIcon.icon)
                        .padding(.vertical)
                        .padding(.top, 40)
                    Text("Your Cuban story hasn’t started yet. Complete your first session.")
                        .font(FontEnum.joSaMedium18.font)
                    
                    Spacer()
                }
                .foregroundColor(isLightTheme ? ColorEnum.col181818.color : ColorEnum.colFFFFFF.color)
                .frame(maxWidth: .infinity)
            }
            
        }
        .padding(.horizontal)
        .font(FontEnum.joSaMedium20.font)
        .foregroundColor(ColorEnum.col181818.color)
    }
}

#Preview {
    VStack {
        HistoryView()
            .padding(.horizontal)
            .environmentObject(CoreDataJournalVM())
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(LinearGradientEnum.mainScreenBg.linearGradientColors)
}
