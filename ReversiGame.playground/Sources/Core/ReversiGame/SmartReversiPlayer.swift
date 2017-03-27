import Foundation

public class SmartReversiPlayer: ReversiPlayer {
    
    public override func makeTurn(game: Game) -> (Int, Int)? {
        guard let g = game as? ReversiGame else {
            return nil
        }
        let children = generateChildren(game: game as! ReversiGame, color: self.color)
        guard children.count > 0 else {
            return nil
        }
        var maxChild : (ReversiGame, Int, Int) = children[0]
        var maxHeur = -Double.infinity
        let other = g.firstPlayer.color == self.color ? g.firstPlayer.color : g.secondPlayer.color
        for child in children {
            let h = -alphaBeta(game: child.0, alpha: -Double.infinity, beta: Double.infinity, depth: 2, color: other)
            if h > maxHeur {
                maxHeur = h
                maxChild = child
            }
            else if h == maxHeur {
                let rand = Int(arc4random()) % 2
                if rand == 0 {
                    maxHeur = h
                    maxChild = child
                }
            }
        }
        return g.step(player: self, maxChild.1, maxChild.2) ? (maxChild.1, maxChild.2) : nil
    }
    
    private static let priority: [Double] = [
        50,  -2,  10,  7,  7,  10,  -2,  50,
        -2,  -5,   0,  2,  2,   0,  -5,  -2,
        10,   0,  10,  5,  5,  10,   0,  10,
         7,   2,   5,  1,  1,   5,   2,   7,
         7,   2,   5,  1,  1,   5,   2,   7,
        10,   0,  10,  5,  5,  10,   0,  10,
        -2,  -5,   0,  2,  2,   0,  -5,  -2,
        50,  -2,  10,  7,  7,  10,  -2,  50
    ]
    
    private func heuristic(game: ReversiGame, color: PlayColor) -> Double {
        var h = 0.0
        for i in 0..<game.boardSize * game.boardSize {
            if game.board[i] == color {
                h += SmartReversiPlayer.priority[i]
            } else {
                h -= game.board[i] != .Empty ? SmartReversiPlayer.priority[i] : 0
            }
        }
        return h / 64.0
    }
    
    private func alphaBeta(game: ReversiGame, alpha: Double, beta: Double, depth: Int, color: PlayColor) -> Double {
        if depth == 0 || game.hasEnded {
            return -heuristic(game: game, color: color)
        }
        var score = beta
        let children : [(ReversiGame, Int, Int)] = generateChildren(game: game, color: color == .Black ? .White : .Black)
        if children.count == 0 {
            return -heuristic(game: game, color: color)
        }
        for child in children {
            let s = -alphaBeta(game: child.0, alpha: -score, beta: -alpha, depth: depth - 1, color: color == .Black ? .White: .Black)
            score = s < score ? s : score
            if score <= alpha {
                return score
            }
        }
        return score
    }
    
    private func generateChildren(game: ReversiGame, color: PlayColor) -> [(ReversiGame, Int, Int)] {
        var children: [(ReversiGame, Int, Int)?] = []
        for i in 0...game.boardSize {
            for j in 0...game.boardSize {
                children.append(next(game: game, color: color, i, j))
            }
        }
        return children.flatMap{ $0 }
    }
    
    private func next(game: ReversiGame, color: PlayColor, _ i: Int, _ j: Int) -> (ReversiGame, Int, Int)? {
        let cloned = ReversiGame()
        cloned.board = game.board
        cloned.firstPlayer = (game.firstPlayer as! ReversiPlayer).clone()
        cloned.secondPlayer = (game.secondPlayer as! ReversiPlayer).clone()
        guard cloned.step(player: (color == cloned.firstPlayer.color ? cloned.firstPlayer : cloned.secondPlayer) as! ReversiPlayer, i, j) else {
            return nil
        }
        return (cloned, i, j)
    }
}
