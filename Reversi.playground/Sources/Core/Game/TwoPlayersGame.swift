import Foundation
import UIKit

public protocol TwoPlayersGame: BoardGame {
    var firstPlayer: Player? { get set }
    var secondPlayer: Player? { get set }
}

public protocol TwoPlayersGameDelegate: GameDelegate {
    var scene : GameController { get set }
    func player(_ player: Player, didTakeAction action: PlayerAction)
    func playerError(_ message: String)
}

extension TwoPlayersGameDelegate {
    public func player(_ player: Player, didTakeAction action: PlayerAction) {
        switch action {
        case .win:
            print("\(player.name) wins!")
        case let .move(square, game):
            //print("\(player.name) moves to [\(square.0 + 1),\(square.1 + 1)]")
            //print(game)
            DispatchQueue.main.sync {
                scene.gameBoard.drawPiece(i: square.1, j: square.0, color: player.color == .Black ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor : #colorLiteral(red: 0.976108253, green: 0.9726067185, blue: 0.9797653556, alpha: 1).cgColor)
            }
        case let .flip(square, _):
            DispatchQueue.main.sync {
                self.scene.gameBoard.drawPiece(i: square.1, j: square.0, color: player.color == .Black ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor : #colorLiteral(red: 0.976108253, green: 0.9726067185, blue: 0.9797653556, alpha: 1).cgColor)
            }
        case .skipTurn:
            scene.showMessage(title: "Warning!", message: "\(player.name) must skip the turn.", button: "OK!")
        }
    }
    
    public func playerError(_ message: String) {
        //scene.showMessage(title: "Error!", message: message, button: "OK!")
        print(message)
    }
}
