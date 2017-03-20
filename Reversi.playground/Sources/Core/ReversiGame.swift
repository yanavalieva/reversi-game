import Foundation

public protocol ReversiGameDelegate: TwoPlayersGameDelegate, TurnbasedGameDelegate {}

public class ReversiGame: TurnbasedGame, TwoPlayersGame {
    public var name = "Reversi"
    public var board: [PlayColor]
    public var boardSize: Int
    public var firstPlayer: Player?
    public var secondPlayer: Player?
    public var delegate: ReversiGameDelegate?
    public var scene: Board?
    
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
    
    public init(scene: Board?) {
        boardSize = 8
        board = Array(repeating: .Empty, count: boardSize * boardSize)
        board[27] = .White
        board[28] = .Black
        board[35] = .Black
        board[36] = .White
        self.scene = scene
    }
    
    public func joinFirst(player: Player) {
        if firstPlayer == nil {
            firstPlayer = player
            firstPlayer?.color = .Black     // first player's color is black
            delegate?.firstPlayer(player, didJoinTheGame: self)
        } else {
            delegate?.playerError("We already have the first player. You can be the second.")
        }
    }
    
    public func joinSecond(player: Player) {
        if firstPlayer == nil {
            delegate?.playerError("Sorry, you can't select this role. You can be the first player.")
        } else if secondPlayer == nil {
            secondPlayer = player
            secondPlayer?.color = .White     // second player's color is white
            delegate?.secondPlayer(player, didJoinTheGame: self)
        }
        else {
            delegate?.playerError("Sorry, we already have enough players :(")
        }
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
        while !hasEnded {
            makeTurn()
            swap(&firstPlayer, &secondPlayer)
        }
        end()
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
        delegate?.player(firstPlayer!, didTakeAction: .move(square: (i, j), game: self, board: scene))
    }
    
    private func checkDirections(_ i: Int, _ j: Int, _ next: (Int, Int) -> (Int, Int)) -> [Int] {
        var deadRivals = 0
        var squares: [Int] = []
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
                squares.append(cur)
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
                board[k] = firstPlayer!.color
            }
            board[index(i, j)] = firstPlayer!.color
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

