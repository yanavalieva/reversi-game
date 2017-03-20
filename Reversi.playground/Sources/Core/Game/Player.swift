import Foundation

public protocol Player {
    var name: String { get }
    var score: Int { get set }
    var color: PlayColor { get set }
}

public enum PlayerAction {
    case win
    case move(square: (Int, Int), game: Game, board: Board?)
    case skipTurn
}

