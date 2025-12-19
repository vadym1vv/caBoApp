
import Foundation

struct PlacesModel: CategoryProtocol, Codable, Identifiable {
    var id: String { title + image }
    let title: String
    let image: String
    let modeEnum: MoodEnum
    let origin: String
    let story: String
    let facts: String
}
