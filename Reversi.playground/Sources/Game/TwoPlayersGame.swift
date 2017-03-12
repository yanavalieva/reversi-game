import Foundation

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
        case let .move(square, game):
            print("\(player.name) moves to [\(square.0 + 1),\(square.1 + 1)]")
            print(game)
        case .skipTurn:
            print("\(player.name) skips the turn")
        }
    }
    
    public func playerError(_ message: String) {
        print(message)
    }
}
