import Foundation
import UIKit

public protocol ReversiGameDelegate: TwoPlayersGameDelegate, TurnbasedGameDelegate {}

public class ReversiGame: TurnbasedGame, TwoPlayersGame {
    public var name = "Reversi"
    public var board: [PlayColor]
    public var boardSize: Int
    public var firstPlayer: Player?
    public var secondPlayer: Player?
    public var delegate: ReversiGameDelegate?
    
    public var didMakeTurn : Bool = false
    public var stopped : Bool = false
    
    public func humanStartsTurn(i: Int, j: Int) {
        didMakeTurn = true
    }
    
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
        firstPlayer = ReversiPlayer(name: "Dark side", color: .Black, score: 2)
        secondPlayer = ReversiPlayer(name: "Light side", color: .White, score: 2)
    }
    
    public func start() {
        firstPlayer?.score = 2
        secondPlayer?.score = 2
        delegate?.gameDidStart(self)
    }
    
    public func end() {
        if firstPlayer!.score == secondPlayer!.score {
            delegate?.drawGame()
        } else {
            delegate?.player(firstPlayer!.score > secondPlayer!.score ?
                firstPlayer! : secondPlayer!, didTakeAction: .win)
        }
        delegate?.gameDidEnd(self)
    }
    
    public func play() {
        guard let _ = firstPlayer, let _ = secondPlayer else {
            delegate?.playerError("No players!")
            return
        }
        start()
        while !hasEnded && !stopped {
            self.makeTurn()
            let _ = DispatchQueue.main.sync {
                sleep(1)
            }
            swap(&firstPlayer, &secondPlayer)
        }
        if stopped {
            delegate?.gameDidStop()
        } else {
            end()
        }
    }
    
    public func stop() {
        stopped = true
    }
    
    public var hasEnded: Bool {
        get {
            guard let fp = firstPlayer, let sp = secondPlayer
            else {
                    return false
            }
            return (fp.score + sp.score) == (boardSize * boardSize)
        }
    }
    
    public func makeTurn() {
        var squares = [(Int, Int)]()
        for i in 0..<boardSize {
            for j in 0..<boardSize {
                if elem(i, j) == PlayColor.Empty {
                    squares.append((i, j))
                }
            }
        }
        if squares.count == 0 {
            return
        }
        var ind = Int(arc4random()) % squares.count
        var (i, j) = squares[ind]
        while !step(i, j){
            squares.remove(at: ind)
            if squares.count == 0 {
                delegate?.player(firstPlayer!, didTakeAction: .skipTurn)
                return
            }
            ind = Int(arc4random()) % squares.count
            (i, j) = squares[ind]
        }
        delegate?.player(firstPlayer!, didTakeAction: .move(square: (i, j), game: self))
    }
    
    private func checkDirections(_ i: Int, _ j: Int, _ next: (Int, Int) -> (Int, Int)) -> [(Int, Int)] {
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
            if (board[cur] == secondPlayer!.color) {
                squares.append((ti, tj))
                deadRivals += 1
            } else if board[cur] == firstPlayer!.color && deadRivals > 0 {
                return squares
            }
            else {
                return []
            }
        }
        return []
    }
    
    public func step(_ i: Int, _ j: Int) -> Bool {
        let total = ReversiGame.directions.map{ checkDirections(i, j, $0) }.flatMap{ $0 }
        if total.count > 0 {
            for k in total {
                board[index(k.0, k.1)] = firstPlayer!.color
                delegate?.player(firstPlayer!, didTakeAction: .flip(square: (k.0, k.1), game: self))
            }
            let id = index(i, j)
            board[id] = firstPlayer!.color
            firstPlayer!.score += total.count + 1
            secondPlayer!.score -= total.count
            return true
        }
        return false
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

