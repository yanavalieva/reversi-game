import Foundation

public protocol Player {
    var name: String { get }
    var score: Int { get set }
    var color: PlayColor { get set }
}

public enum PlayerAction {
    case move(square: (Int, Int))
    case skipTurn
    case flip(square: (Int, Int))
}

public enum PlayColor: Character {
    case White = "⚪️"
    case Black = "⚫️"
    case Empty = "🔹"
}
