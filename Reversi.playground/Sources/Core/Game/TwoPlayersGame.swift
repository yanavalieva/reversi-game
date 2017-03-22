import Foundation
import UIKit

public protocol TwoPlayersGame: BoardGame {
    var firstPlayer: Player? { get set }
    var secondPlayer: Player? { get set }
    func joinFirst(player: Player)
    func joinSecond(player: Player)
}

public protocol TwoPlayersGameDelegate: GameDelegate {
    var scene : Board { get set }
    func firstPlayer(_ player: Player, didJoinTheGame game: TwoPlayersGame)
    func secondPlayer(_ player: Player, didJoinTheGame game: TwoPlayersGame)
    func player(_ player: Player, didTakeAction action: PlayerAction)
    func playerError(_ message: String)
}

extension TwoPlayersGameDelegate {
    public func firstPlayer(_ player: Player, didJoinTheGame game: TwoPlayersGame) {
        print("\(player.name) has selected black pieces")
    }
    
    public func secondPlayer(_ player: Player, didJoinTheGame game: TwoPlayersGame) {
        print("\(player.name) has selected white pieces")
    }
    
    public func player(_ player: Player, didTakeAction action: PlayerAction) {
        switch action {
        case .win:
            print("\(player.name) wins!")
        case let .move(square, game):
            print("\(player.name) moves to [\(square.0 + 1),\(square.1 + 1)]")
            print(game)
            DispatchQueue.main.sync {
                scene.drawPiece(i: square.1, j: square.0, color: player.color == .Black ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor : #colorLiteral(red: 0.976108253, green: 0.9726067185, blue: 0.9797653556, alpha: 1).cgColor)
                
            }
        case let .flip(square, _):
            DispatchQueue.main.async {
                self.scene.drawPiece(i: square.1, j: square.0, color: player.color == .Black ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor : #colorLiteral(red: 0.976108253, green: 0.9726067185, blue: 0.9797653556, alpha: 1).cgColor)
            }
        case .skipTurn:
            print("\(player.name) skips the turn")
        }
    }
    
    public func playerError(_ message: String) {
        print(message)
    }
}
