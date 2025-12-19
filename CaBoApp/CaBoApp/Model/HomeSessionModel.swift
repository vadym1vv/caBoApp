
import Foundation

struct HomeSessionModel: CategoryProtocol, Codable, Identifiable {
    var id: String { title + image }
    let title: String
    let image: String
    let modeEnum: MoodEnum
    let dificulty: DifficultyEnum
    let timeForSession: TimeForSessionEnum
    let prepare: String
    let mix: String
    let listen: String
    let reflect: String
}

