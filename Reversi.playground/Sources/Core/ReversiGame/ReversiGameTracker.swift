import Foundation

public protocol ReversiGameDelegate: TwoPlayersGameDelegate, TurnbasedGameDelegate {}

public class ReversiPlayer: Player {
    public let name: String
    public var score: Int = 0
    public var color: PlayColor
    
    public init(name: String, color: PlayColor = .Empty, score: Int = 2) {
        self.name = name
        self.color = color
        self.score = score
    }
    
    public func clone() -> ReversiPlayer {
        return ReversiPlayer(name: self.name, color: self.color, score: self.score)
    }
}

public class ReversiGameTracker: ReversiGameDelegate {
    
    public var scene : GameController
    
    public init(scene: GameController) {
        self.scene = scene
    }
    
    public func gameDidStop() {
        DispatchQueue.main.sync {
            self.scene.gameBoard.reset()
        }
    }
    
    public func highlightCell(i: Int, j: Int) {
        DispatchQueue.main.sync {
            scene.gameBoard.drawCell(i: i, j: j)
        }
    }
}
