import Foundation

public protocol Game {
    var name: String { get }
    func play()
}

public protocol GameDelegate {
    func gameDidStart(_ game: Game)
    func gameDidEnd()
    func drawGame()
}

extension GameDelegate {
    public func gameDidStart(_ game: Game) {
        print("\nThe \(game.name)-game is on!\n")
    }
    
    public func gameDidEnd() {
        print("Game over!")
    }
    
    public func drawGame() {
        print("Draw game!")
    }
}
