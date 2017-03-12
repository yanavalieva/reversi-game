public class ReversiPlayer: Player {
    public let name: String
    public var score: Int = 0
    public var color: PlayColor
    
    public init(name: String) {
        self.name = name
        self.color = .Empty
        self.score = 2
    }
}

public class ReversiGameTracker: ReversiGameDelegate {
    public init(){}
}
