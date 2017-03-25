public protocol Game {
    var name: String { get }
    var hasEnded: Bool { get }
    func play()
    func end()
}

public protocol GameDelegate {
    func gameDidEnd(_ game: Game)
    func gameDidStop()
    func drawGame()
}

extension GameDelegate {
    
    public func gameDidStop() {
        print("Game over!")
    }
    
    public func gameDidEnd(_ game: Game) {
        print("Game over!")
    }
    
    public func drawGame() {
        print("Draw game!")
    }
}
