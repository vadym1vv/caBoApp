
import Foundation

struct CocktailModel: CategoryProtocol, Codable, Identifiable {
    var id: String { title + image }
    let title: String
    let image: String
    let modeEnum: MoodEnum
    let dificulty: DifficultyEnum
    let ingredients: String
    let origin: String
    let story: String
    let facts: String
}


protocol CategoryProtocol: Identifiable {
    var id: String { get }
    var image: String { get }
    var title: String { get }
    var modeEnum: MoodEnum { get }
}

