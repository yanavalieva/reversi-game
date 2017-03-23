import Foundation
import UIKit

public protocol Game {
    var name: String { get }
    func play()
}

public protocol GameDelegate {
    func gameDidEnd(_ game: Game)
    func gameDidStop()
    func drawGame()
}

extension GameDelegate {

    public func gameDidEnd(_ game: Game) {
        print("Game over!")
    }
    
    public func drawGame() {
        print("Draw game!")
    }
}
