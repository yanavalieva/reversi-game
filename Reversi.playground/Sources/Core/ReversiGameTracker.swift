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
}
