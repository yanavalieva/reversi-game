import Foundation

public protocol ReversiGameDelegate: TwoPlayersGameDelegate {}

public class ReversiGameTracker: ReversiGameDelegate {
    
    public var scene : GameController
    
    public init(scene: GameController ) {
        self.scene = scene
    }
}
