import SwiftUI

enum StatTimeRange: String, CaseIterable, Identifiable {
    var id: Self {self}
    case week = "This week", month = "This month", all = "All time"
}

struct CategoryCount: Identifiable {
    let id = UUID()
    let category: CategoryEnum
    let count: Int
    let color: Color
    var startAngle: Angle = .degrees(0)
    var endAngle: Angle = .degrees(0)
}

struct StatView: View {
    @EnvironmentObject private var coreDataJournalVM: CoreDataJournalVM
    @State private var selectedRange: StatTimeRange = .week
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Statistics")
                .font(.system(size: 28, weight: .bold))
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: UIScreen.main.bounds.width / 20) {
                Spacer()
                ForEach(StatTimeRange.allCases) { range in
                    
                    Button {
                        selectedRange = range
                    } label: {
                        Text(range.rawValue)
                            .font(FontEnum.joSaMedium14.font)
                            .frame(maxHeight: .infinity)
                            .padding(.horizontal)
                            .background(selectedRange == range ? ColorEnum.colFFC8AF.color : ColorEnum.colFFFFFF.color)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                }
                Spacer()
            }
            .font(FontEnum.joSaMedium14.font)
            .foregroundColor(ColorEnum.col181818.color)
            .frame(height: UIScreen.main.bounds.height / 25)
            .frame(maxWidth: .infinity)
            
            
            legendList
            HStack {
                Spacer()
                ZStack {
                    Circle()
                        .stroke(ColorEnum.colFFFFFF.color, lineWidth: 32)
                    
                    ForEach(chartData) { data in
                        Circle()
                            .trim(from: CGFloat(data.startAngle.degrees / 360),
                                  to: CGFloat(data.endAngle.degrees / 360))
                            .stroke(data.color, style: StrokeStyle(lineWidth: 30, lineCap: .butt))
                            .rotationEffect(.degrees(-90))
                    }
                    
                    
                }
                .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
                .padding(.vertical, 30)
                Spacer()
                
                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Circle()
                                .frame(width: 12, height: 12)
                                .foregroundColor(ColorEnum.col926EF8.color)
                            Text("Relax")
                        }
                        HStack {
                            Circle()
                                .frame(width: 12, height: 12)
                                .foregroundColor(ColorEnum.col008080.color)
                            Text("Party")
                        }
                        
                        HStack {
                            Circle()
                                .frame(width: 12, height: 12)
                                .foregroundColor(ColorEnum.colFF6F61.color)
                            Text("Deep")
                        }
                        
                        HStack {
                            Circle()
                                .frame(width: 12, height: 12)
                                .foregroundColor(ColorEnum.colF98F75.color)
                            Text("Romantic")
                        }
                        
                    }
                    .padding()
                }
                .background(ColorEnum.colFFFFFF.color)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                Spacer()
            }
            Spacer()
        }
    }

    
    private var chartData: [CategoryCount] {
        let filtered = filterEntities()
        let total = Double(filtered.count)
        var currentAngle: Double = 0
        let gapSize: Double = 2.0
        
        if total > 0 {
         
            return CategoryEnum.allCases.map { cat in
                let count = filtered.filter { $0.itemCategory == cat.rawValue }.count
                let percentage = Double(count) / total
                let degrees = percentage * 360
                
                let data = CategoryCount(
                    category: cat,
                    count: count,
                    color: cat.color,
                    startAngle: .degrees(currentAngle + (degrees > 0 ? gapSize / 2 : 0)),
                    endAngle: .degrees(currentAngle + degrees - (degrees > 0 ? gapSize / 2 : 0))
                )
                currentAngle += degrees
                return data
            }
        } else {
            
            let dummyPercentages = [0.35, 0.25, 0.20, 0.20]
            let allCategories = CategoryEnum.allCases
            
            return allCategories.indices.map { index in
                let cat = allCategories[index]
                let percentage = dummyPercentages[index]
                let degrees = percentage * 360
                
                let data = CategoryCount(
                    category: cat,
                    count: 0,
                    color: cat.color,
                    startAngle: .degrees(currentAngle + (gapSize / 2)),
                    endAngle: .degrees(currentAngle + degrees - (gapSize / 2))
                )
                currentAngle += degrees
                return data
            }
        }
    }

    private func filterEntities() -> [JournalItemEntity] {
        let now = Date()
        return coreDataJournalVM.journalItemEntities.filter { entity in
            guard let date = entity.date else { return false }
            switch selectedRange {
            case .week: return Calendar.current.isDate(date, equalTo: now, toGranularity: .weekOfYear)
            case .month: return Calendar.current.isDate(date, equalTo: now, toGranularity: .month)
            case .all: return true
            }
        }
    }
    

}

extension StatView {
    private var legendList: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(chartData) { item in
                HStack {
                    Image(item.category.iconButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                        .padding(.leading)
                    Text(item.category.longDescription).font(.subheadline)
                    Spacer()
                    Text("\(item.count)").fontWeight(.bold)
                        .frame(width: 36, height: 36)
                        .background(ColorEnum.colFFA07A.color)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(12)
                        .opacity(item.count > 0 ? 1 : 0.5)
                }
                .background(ColorEnum.colFFC8AF.color)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
            }
        }
    }
    
}


#Preview {
    VStack {
        StatView()
            .environmentObject(CoreDataJournalVM())
    }
    .background(LinearGradientEnum.mainScreenBg.linearGradientColors)
}
