public protocol Game {
    var name: String { get }
    var hasEnded: Bool { get }
    func play()
    func start()
    func end()
}

public protocol GameDelegate {
    func gameDidStart()
    func gameDidEnd(_ game: Game)
    func gameDidStop()
    func drawGame()
}

extension GameDelegate {
    
    public func gameDidStart() {
        print("The game is on!")
    }
    
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
