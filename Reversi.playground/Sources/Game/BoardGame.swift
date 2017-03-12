import Foundation

public protocol BoardGame: Game {
    var board: [PlayColor] { get }
    var boardSize: Int { get }
}

extension BoardGame {
    public func index(_ i: Int, _ j: Int) -> Int {
        if (i < 0 || i > self.boardSize - 1 || j < 0 || j > self.boardSize - 1) {
            return -1
        } else {
            return i * self.boardSize + j;
        }
    }
    
    public func elem(_ i: Int, _ j: Int) -> PlayColor? {
        let id = index(i, j)
        if id > -1 {
            return self.board[id]
        } else {
            return nil
        }
    }
}

public enum PlayColor: Character {
    case White = "⚪️"
    case Black = "⚫️"
    case Empty = "🔹"
}


