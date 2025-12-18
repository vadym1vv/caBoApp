//
//  ExportUtility.swift
//  CaBoApp
//
//  Created by Vadym Vasylaki on 18.12.2025.
//


import UIKit

struct ExportUtility {
    
    static func shareFile(content: String, fileName: String) {
       
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        
        do {
            try content.write(to: tempURL, atomically: true, encoding: .utf8)
            presentShareSheet(items: [tempURL])
        } catch {
            print("Error creating export file: \(error.localizedDescription)")
        }
    }
    
    private static func presentShareSheet(items: [Any]) {
        let av = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        av.excludedActivityTypes = [.addToReadingList, .assignToContact]
        
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootVC = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                
                av.popoverPresentationController?.sourceView = rootVC.view
                av.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY, width: 0, height: 0)
                av.popoverPresentationController?.permittedArrowDirections = []
                
                rootVC.present(av, animated: true, completion: nil)
            }
        }
    }
}
