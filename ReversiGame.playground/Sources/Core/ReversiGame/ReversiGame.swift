import Foundation
import UIKit

public class ReversiGame: TwoPlayersGame {
    public var name = "Reversi"
    public var board: [PlayColor]
    public var boardSize: Int
    public var firstPlayer: Player!
    public var secondPlayer: Player!
    public var delegate: ReversiGameDelegate?
    public var stopped : Bool = false
    
    static let directions = [
        { ($0 - 1, $1) },
        { ($0 - 1, $1 + 1) },
        { ($0, $1 + 1) },
        { ($0 + 1, $1 - 1) },
        { ($0 + 1, $1) },
        { ($0 + 1, $1 + 1) },
        { ($0, $1 - 1) },
        { ($0 - 1, $1 - 1) }
    ]
    
    public init() {
        boardSize = 8
        board = Array(repeating: .Empty, count: boardSize * boardSize)
        board[27] = .White
        board[28] = .Black
        board[35] = .Black
        board[36] = .White
    }
    
    public func start() {
        delegate?.gameDidStart()
    }
    
    public func end() {
        if firstPlayer.score == secondPlayer.score {
            delegate?.drawGame()
        } else {
            delegate?.gameDidEnd(self)
        }
    }
    
    internal var skipped = false
    
    public func play() {
        start()
        while !hasEnded && !stopped {
            if !processStep(player: firstPlayer) {
                return
            }
            if hasEnded || stopped {
                break
            } else {
                if !processStep(player: secondPlayer) {
                    return
                }
            }
        }
        if stopped {
            delegate?.gameDidStop()
        } else {
            end()
        }
    }
    
    internal func processStep(player: Player) -> Bool {
        if let square = player.makeTurn(game: self) {
            delegate?.player(player, didTakeAction: .move(square: square))
            skipped = false
        } else {
            if !skipped {
                delegate?.player(player, didTakeAction: .skipTurn)
                skipped = true
            } else {
                delegate?.drawGame()
                return false
            }
        }
        return true
    }
    
    public func stop() {
        stopped = true
    }
    
    public var hasEnded: Bool {
        get {
            return (firstPlayer.score + secondPlayer.score) == (boardSize * boardSize)
        }
    }
    
    public func step(player: ReversiPlayer, _ i: Int, _ j: Int) -> Bool {
        var other = firstPlayer.color == player.color ? secondPlayer : firstPlayer
        let total = ReversiGame.directions.map{ checkDirections(player: player, other: other as! ReversiPlayer, i, j, next: $0) }.flatMap{ $0 }
        if total.count > 0 {
            for k in total {
                board[index(k.0, k.1)] = player.color
                delegate?.player(player, didTakeAction: .flip(square: (k.0, k.1)))
            }
            let id = index(i, j)
            board[id] = player.color
            player.score += total.count + 1
            other?.score -= total.count
            return true
        }
        return false
    }
    
    private func checkDirections(player: ReversiPlayer, other: ReversiPlayer, _ i: Int, _ j: Int, next: (Int, Int) -> (Int, Int)) -> [(Int, Int)] {
        var deadRivals = 0
        var squares: [(Int, Int)] = []
        var ti = i, tj = j
        if (elem(ti, tj) != PlayColor.Empty) {
            return []
        }
        while (ti >= 0 && ti < boardSize && tj >= 0 && tj < boardSize) {
            (ti, tj) = next(ti, tj)
            let cur = index(ti, tj)
            if cur == -1 {
                return []
            }
            if (board[cur] == other.color) {
                squares.append((ti, tj))
                deadRivals += 1
            } else if board[cur] == player.color && deadRivals > 0 {
                return squares
            }
            else {
                return []
            }
        }
        return []
    }
}

extension ReversiGame: CustomStringConvertible {
    public var description: String {
        var result = ""
        for i in 0..<boardSize {
            for j in 0..<boardSize {
                result.append(elem(i, j)!.rawValue)
            }
            result.append("\n")
        }
        return String(result)
    }
}
