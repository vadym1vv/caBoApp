//
//  SettingsView.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 11.12.2025.
//

import SwiftUI

struct SettingsView: View {
    
    
    @AppStorage("isLightTheme") private var isLightTheme: Bool = true
    @AppStorage("com.caboapp.export") private var isExportUnlocked: Bool = false
    @AppStorage("com.caboapp.reset") private var isResetUnlocked: Bool = false
    @State private var sessionReminder: Bool = false
    
    @EnvironmentObject private var coreDataUserProgressVM: CoreDataUserProgressVM
    @EnvironmentObject private var coreDataJournalVM: CoreDataJournalVM
    @EnvironmentObject private var coreDataSearchEntityVM: CoreDataSearchEntityVM
    
    @State private var showUnlockExportPaywall: Bool = false
    @State private var showUnlockResetPaywall: Bool = false
    @State private var showResetAlert: Bool = false
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        ZStack {
            if (showUnlockResetPaywall) {
                PaywallComponent(showPurchasePlaywall: $showUnlockResetPaywall, titleIcon: .resetIcon, unlockIcon: IconEnum.lockIconSmall, purchaseTitle: "Reset progress", purchaseDescription: "This one-time purchase lets you completely reset your CaBo journey whenever you want.", purchaseButtonLabel: "Unlock Reset") {
                    if !isResetUnlocked {
                        IAPManager.shared.purchase(productID: "com.caboapp.reset")
                    }
                }
                .zIndex(1)
            }
            
            if (showUnlockExportPaywall) {
                PaywallComponent(showPurchasePlaywall: $showUnlockExportPaywall, titleIcon: .exportDataIcon, unlockIcon: IconEnum.lockIconSmall, purchaseTitle: "Export data (CSV/JSON)", purchaseDescription: "Enable export to CaBo to save recipes, rituals, and cultural sessions for your projects.", purchaseButtonLabel: "Unlock Export") {
                    if !isExportUnlocked {
                        IAPManager.shared.purchase(productID: "com.caboapp.export")
                    }
                }
                .zIndex(1)
            }
            
            if (showResetAlert) {
                PaywallComponent(showPurchasePlaywall: $showResetAlert, titleIcon: nil, unlockIcon: .resetIcon, laterIcon: nil, purchaseTitle: "Are you sure?", purchaseDescription: "This will delete all your local data: favorites, stats, journal. This action cannot be undone.", purchaseButtonLabel: "Reset now", cancelBtnDescription: "Cancel") {
                    coreDataUserProgressVM.deleteAllEntities()
                    coreDataJournalVM.deleteAllEntities()
                    coreDataSearchEntityVM.deleteAllEntities()
                    UserDefaults.standard.set(nil, forKey: "lastJourneyType")
                    UserDefaults.standard.set(0, forKey: "lastItemIndex")
                }
                .zIndex(1)
            }
            if (showUnlockResetPaywall || showUnlockExportPaywall || showResetAlert){
                ColorEnum.col181818.color.opacity(0.7)
                    .zIndex(0.9)
            }
            
            VStack {
                TopBarNavigationComponent(leadingView: HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(IconEnum.backBtn.icon)
                    }
                    Text("Settings")
                        .font(FontEnum.joSaBold24.font)
                        .foregroundColor(isLightTheme ? ColorEnum.col181818.color : ColorEnum.colFFFFFF.color)
                    
                }, centerView: EmptyView(), trailingView: EmptyView())
                .padding(.top, getSafeArea().top)
                
                VStack(alignment: .leading, spacing: GlobalConstant.viewComponentSpacing) {
                    Text("Themes/Appearance")
                    HStack {
                        Text("Theme")
                            .font(FontEnum.joSaMedium18.font)
                            .layoutPriority(1)
                            .padding(.leading)
                        Spacer()
                        ZStack {
                            if (isLightTheme) {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(ColorEnum.colFF6F61.color)
                            }
                            Button {
                                withAnimation {
                                    isLightTheme = true
                                }
                            } label: {
                                Text("Brisa Cubana")
                                    .font(FontEnum.joSaRegular16.font)
                                    .frame(maxHeight: .infinity)
                                
                            }
                        }
                        .frame(width: 110)
                        .padding(.vertical, 7)
                        
                        ZStack {
                            if (!isLightTheme) {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(ColorEnum.colFF6F61.color)
                            }
                            Button {
                                withAnimation {
                                    withAnimation {
                                        isLightTheme = false
                                    }
                                }
                            } label: {
                                Text("Cuban Night")
                                    .font(FontEnum.joSaRegular16.font)
                                    .frame(maxHeight: .infinity)
                                
                            }
                        }
                        .frame(width: 110)
                        .padding(.vertical,7)
                        .padding(.trailing)
                    }
                    .frame(height: UIScreen.main.bounds.height / 15)
                    .background(ColorEnum.colFFC8AF.color)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .foregroundColor(ColorEnum.col181818.color)
                    Text("Preferences")
                    HStack {
                        Text("Session reminder")
                            .font(FontEnum.joSaMedium18.font)
                            .foregroundColor(ColorEnum.col181818.color)
                            .padding()
                        Spacer()
                        Toggle(isOn: $sessionReminder) {
                            Text("")
                        }
                        .padding()
                    }
                    .frame(height: UIScreen.main.bounds.height / 15)
                    .background(ColorEnum.colFFC8AF.color)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Text("Data & Progress(IAP)")
                    if (isExportUnlocked) {
                        VStack {
                            HStack {
                                Image(IconEnum.exportDataIcon.icon)
                                Text("Export Data(CSV/JSON)")
                                    .foregroundColor(ColorEnum.col181818.color)
                                    .font(FontEnum.joSaMedium18.font)
                            }
                            .font(FontEnum.joSaLight16.font)
                            .padding(.top, 5)
                            
                            HStack {
                                Button {
                                    exportData(format: .csv)
                                } label: {
                                    Text("Export in CSV format")
                                        .font(FontEnum.joSaRegular16.font)
                                        .frame(maxWidth: .infinity)
                                        .padding(.horizontal, 3)
                                        .font(FontEnum.joSaRegular16.font)
                                        .frame(minHeight: 44)
                                        .background(ColorEnum.colFFA07A.color)
                                        .foregroundColor(ColorEnum.col181818.color)
                                        .clipShape(RoundedRectangle(cornerRadius: 24))
                                }
                                
                                Button {
                                    exportData(format: .json)
                                } label: {
                                    Text("Export in JSON format")
                                        .font(FontEnum.joSaRegular16.font)
                                        .frame(maxWidth: .infinity)
                                        .frame(minHeight: 44)
                                        .padding(.horizontal, 3)
                                        .background(ColorEnum.colF0A89A.color)
                                        .foregroundColor(ColorEnum.col181818.color)
                                        .clipShape(RoundedRectangle(cornerRadius: 24))
                                }
                                
                            }
                            .padding([.horizontal, .bottom], 6)
                        }
                        .background(ColorEnum.colFFC8AF.color)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    } else {
                        VStack {
                            HStack  {
                                Image(isExportUnlocked ? IconEnum.resetIcon.icon : IconEnum.lockIcon.icon)
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Export data (CSV/JSON)")
                                        .font(FontEnum.joSaMedium18.font)
                                    Text("Export your journal and sessions to a file.")
                                        .font(FontEnum.joSaLight16.font)
                                }
                                Spacer()
                                if !isExportUnlocked { Text("$1.99").font(FontEnum.joSaBold16.font) }
                            }
                            .foregroundColor(ColorEnum.col181818.color)
                            .padding([.top, .horizontal])
                            Button {
                                withAnimation {
                                    showUnlockExportPaywall = true
                                }
                            } label: {
                                HStack {
                                    if !isExportUnlocked { Image(IconEnum.lockIconSmall.icon) }
                                    Text("Unlock Export")
                                        .font(FontEnum.joSaMedium16.font)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: UIScreen.main.bounds.height / 18)
                                .background(ColorEnum.colFF6F61.color)
                                .foregroundColor(ColorEnum.colFFFFFF.color)
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                            }
                            .padding()
                        }
                        .background(ColorEnum.colFFC8AF.color)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    if(!isResetUnlocked) {
                        VStack {
                            HStack  {
                                Image(IconEnum.lockIcon.icon)
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Reset progress")
                                        .font(FontEnum.joSaMedium18.font)
                                    Text("Unlock the option to wipe all local data and start fresh.")
                                        .font(FontEnum.joSaLight16.font)
                                }
                                Spacer()
                                if !isResetUnlocked { Text("$1.99").font(FontEnum.joSaBold16.font) }
                            }
                            .foregroundColor(ColorEnum.col181818.color)
                            .padding([.top, .horizontal])
                            
                            Button {
                                withAnimation {
                                    showUnlockResetPaywall = true
                                }
                            } label: {
                                HStack {
                                    Image(IconEnum.lockIconSmall.icon)
                                    Text("Unlock Reset")
                                        .font(FontEnum.joSaMedium16.font)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: UIScreen.main.bounds.height / 18)
                                .background(ColorEnum.colF77D4E.color)
                                .foregroundColor(ColorEnum.colFFFFFF.color)
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                            }
                            .padding()
                        }
                        .background(ColorEnum.colFFC8AF.color)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .padding(.horizontal)
                
                if (isResetUnlocked) {
                    Spacer()
                }
                Spacer()
                
                VStack {
                    if (isResetUnlocked) {
                        Button {
                            withAnimation {
                                showResetAlert = true
                            }
                        } label: {
                            HStack {
                                Image(IconEnum.resetIcon.icon)
                                    .renderingMode(.template)
                                    .foregroundColor(ColorEnum.colFFFFFF.color)
                                Text("Reset progress")
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: UIScreen.main.bounds.height / 18)
                            .background(ColorEnum.colFF5D4D.color)
                            .foregroundColor(ColorEnum.colFFFFFF.color)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                        }
                    }
                    
                    NavigationLink {
                        AboutAppView()
                    } label: {
                        HStack {
                            Image(IconEnum.aboutAppIcon.icon)
                            Text("About the app")
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: UIScreen.main.bounds.height / 18)
                        .background(ColorEnum.colFFFFFF.color)
                        .foregroundColor(ColorEnum.col181818.color)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                    }
                    
                }
                .frame(width:  UIScreen.main.bounds.width / 1.4)
                Spacer()
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .font(FontEnum.joSaMedium20.font)
        .foregroundColor(isLightTheme ? ColorEnum.col181818.color : ColorEnum.colFFFFFF.color)
        .background(isLightTheme ? LinearGradientEnum.mainScreenBg.linearGradientColors : LinearGradientEnum.darkBackgorund.linearGradientColors)
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .onAppear {
            IAPManager.shared.fetchProducts()
        }
        
    }
    
    
    enum ExportFormat { case csv, json }
    
    private func exportData(format: ExportFormat) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        switch format {
        case .csv:
            generateCSV(formatter: dateFormatter)
        case .json:
            generateJSON(formatter: dateFormatter)
        }
    }
    
    private func generateCSV(formatter: DateFormatter) {
        var csvString = "Section,Title,Category/Type,Date,Details\n"
        
        for item in coreDataUserProgressVM.items {
            let name = cleanCSV(item.itemName)
            let type = cleanCSV(item.itemType)
            let date = formatter.string(from: item.introducedDate ?? Date())
            let details = item.isFavorite ? "Favorite" : ""
            csvString += "Progress,\(name),\(type),\(date),\(details)\n"
        }
        
        for entry in coreDataJournalVM.journalItemEntities {
            let title = cleanCSV(entry.itemTitle)
            let cat = cleanCSV(entry.itemCategory)
            let date = formatter.string(from: entry.date ?? Date())
            csvString += "Journal,\(title),\(cat),\(date),\n"
        }
        
        for search in coreDataSearchEntityVM.searchRequests {
            let query = cleanCSV(search.searchString)
            let type = cleanCSV(search.typeCategory)
            let date = formatter.string(from: search.searchDate ?? Date())
            let details = "Mood: \(search.mood ?? "-") | Diff: \(search.difficulty ?? "-")"
            csvString += "Search,\(query),\(type),\(date),\(cleanCSV(details))\n"
        }
        
        ExportUtility.shareFile(content: csvString, fileName: "CaBo_Export.csv")
    }
    
    private func generateJSON(formatter: DateFormatter) {
        
        let exportDict: [String: Any] = [
            "userProgress": coreDataUserProgressVM.items.map { item in
                return [
                    "name": item.itemName ?? "",
                    "type": item.itemType ?? "",
                    "isFavorite": item.isFavorite,
                    "date": formatter.string(from: item.introducedDate ?? Date())
                ]
            },
            "journalEntries": coreDataJournalVM.journalItemEntities.map { entry in
                return [
                    "title": entry.itemTitle ?? "",
                    "category": entry.itemCategory ?? "",
                    "date": formatter.string(from: entry.date ?? Date())
                ]
            },
            "searchHistory": coreDataSearchEntityVM.searchRequests.map { search in
                return [
                    "query": search.searchString ?? "",
                    "type": search.typeCategory ?? "",
                    "mood": search.mood ?? "",
                    "difficulty": search.difficulty ?? "",
                    "timeNeeded": search.timeNeeded ?? "",
                    "date": formatter.string(from: search.searchDate ?? Date())
                ]
            }
        ]
        
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: exportDict, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            ExportUtility.shareFile(content: jsonString, fileName: "CaBo_Export.json")
        }
    }
    
    
    private func cleanCSV(_ text: String?) -> String {
        guard let text = text else { return "" }
        if text.contains(",") || text.contains("\n") {
            return "\"\(text.replacingOccurrences(of: "\"", with: "\"\""))\""
        }
        return text
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(CoreDataSearchEntityVM())
            .environmentObject(CoreDataUserProgressVM())
            .environmentObject(CoreDataJournalVM())
    }
}



