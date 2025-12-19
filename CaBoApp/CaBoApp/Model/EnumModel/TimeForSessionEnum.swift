
import Foundation

enum TimeForSessionEnum: String, CaseIterable, Identifiable, Codable {
    var id: String { rawValue }
    
    case tenTwenty = "10-20min"
    case twentyForty = "20-40min"
    case twentyFive = "25 min"
    case twenty = "20 min"
    case fortyPlus = "40+ min"
    case thirtyFive = "35 min"
    
    var longDescription: String {
        switch self {
        case .tenTwenty:
            return "10-20 minutes"
        case .twentyForty:
            return "20-40 minutes"
        case .twentyFive:
            return "25 minutes"
        case .twenty:
            return "20 minutes"
        case .fortyPlus:
            return "40+ minutes"
        case .thirtyFive:
            return "35 minutes"
        }
    }
    
    static let timeForFilter: [TimeForSessionEnum] = [.tenTwenty, .twentyForty, .fortyPlus]
}
