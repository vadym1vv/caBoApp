
import Foundation

enum MoodEnum: String, Identifiable, CaseIterable, Codable {
    var id: String { rawValue }    
    case relax, party, deep, romantic
}
