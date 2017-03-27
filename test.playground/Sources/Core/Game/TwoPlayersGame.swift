import Foundation
import UIKit

public protocol TwoPlayersGame: BoardGame {
    var firstPlayer: Player! { get set }
    var secondPlayer: Player! { get set }
}

public protocol TwoPlayersGameDelegate: BoardGameDelegate {
    func player(_ player: Player, didTakeAction action: PlayerAction)
    func playerError(_ message: String)
}

extension TwoPlayersGameDelegate {
    public func player(_ player: Player, didTakeAction action: PlayerAction) {
        switch action {
        case let .move(square):
            DispatchQueue.main.sync {
                scene.updateState(message: "The game is on!")
                scene.gameBoard.drawPiece(i: square.1, j: square.0, color: player.color == .Black ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor : #colorLiteral(red: 0.976108253, green: 0.9726067185, blue: 0.9797653556, alpha: 1).cgColor)
            }
        case let .flip(square):
            DispatchQueue.main.sync {
                self.scene.gameBoard.drawPiece(i: square.1, j: square.0, color: player.color == .Black ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor : #colorLiteral(red: 0.976108253, green: 0.9726067185, blue: 0.9797653556, alpha: 1).cgColor)
            }
        case .skipTurn:
            print("Skip turn")
            DispatchQueue.main.sync {
                scene.updateState(message: "\(player.name) must skip the turn.")
            }
        }
    }
    
    public func gameDidEnd(_ game: Game) {
        if let g = game as? TwoPlayersGame {
            let winner = g.firstPlayer.score > g.secondPlayer.score ? g.firstPlayer : g.secondPlayer
            DispatchQueue.main.sync {
                scene.updateState(message: "\(winner!.name) won! Score [ \(g.firstPlayer!.score) : \(g.secondPlayer!.score) ]")
            }
        }
    }
    
    public func playerError(_ message: String) {
        DispatchQueue.main.sync {
            scene.updateState(message: message)
        }
    }
    
}
