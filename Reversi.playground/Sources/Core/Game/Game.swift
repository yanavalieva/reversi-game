import Foundation
import UIKit

public protocol Game {
    var name: String { get }
    func play()
}

public protocol GameDelegate {
    func gameDidStart(_ game: Game)
    func gameDidEnd(_ game: Game)
    func gameDidStop()
    func drawGame()
}

extension GameDelegate {
    public func gameDidStart(_ game: Game) {
        print("\nThe \(game.name)-game is on!\n")
    }
    
    public func gameDidEnd(_ game: Game) {
        print("Game over!")
    }
    
    public func drawGame() {
        print("Draw game!")
    }
}
