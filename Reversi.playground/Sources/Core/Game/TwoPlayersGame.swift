import Foundation
import UIKit

public protocol TwoPlayersGame: BoardGame {
    var firstPlayer: Player? { get set }
    var secondPlayer: Player? { get set }
    func joinFirst(player: Player)
    func joinSecond(player: Player)
}

public protocol TwoPlayersGameDelegate: GameDelegate {
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
        case let .move(square, game, scene):
            print("\(player.name) moves to [\(square.0 + 1),\(square.1 + 1)]")
            print(game)
            scene?.drawPiece(i: square.0, j: square.1, color: player.color == .Black ?
                #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor)
        case .skipTurn:
            print("\(player.name) skips the turn")
        }
    }
    
    public func playerError(_ message: String) {
        print(message)
    }
}
