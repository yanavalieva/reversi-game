import Foundation

public class ReversiAIGame : ReversiGame {
 
    public override func makeTurn() {
        let children = generateChildren()
        guard children.count > 0 else {
            delegate?.player(firstPlayer!, didTakeAction: .skipTurn)
            return
        }
        var maxChild : (ReversiAIGame, Int, Int) = children[0]
        var maxHeur = -Double.infinity
        for child in children {
            let h = -child.0.alphaBeta(
                alpha: -Double.infinity, beta: Double.infinity, depth: 0)
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
        if step(maxChild.1, maxChild.2) {
            delegate?.player(firstPlayer!, didTakeAction: .move(square: (maxChild.1, maxChild.2)))
        } else {
            delegate?.playerError("Something went wrong")
        }
    }
    
    public override func play() {
        while !hasEnded && !stopped {
            self.makeTurn()
            swap(&firstPlayer, &secondPlayer)
        }
        if stopped {
            delegate?.gameDidStop()
        } else {
            end()
        }
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
    
    func heuristic() -> Double {
        var h = 0.0
        for i in 0...boardSize {
            if board[i] == firstPlayer?.color {
                h += ReversiAIGame.priority[i]
            }
            if board[i] == secondPlayer?.color {
                h -= ReversiAIGame.priority[i]
            }
        }
        return h / 64.0 * Double(firstPlayer!.score)
    }
 
    func alphaBeta(alpha: Double, beta: Double, depth: Int) -> Double {
        if depth == 0 || hasEnded {
            return -heuristic()
        }
        var score = beta
        let children = generateChildren()
        if children.count == 0 {
            return -heuristic()
        }
        for child in children {
            let s = -child.0.alphaBeta(alpha: -score, beta: -alpha, depth: depth - 1)
            score = s < score ? s : score
            if score <= alpha {
                return score
            }
        }
        return score
    }
    
    func next(_ i: Int, _ j: Int) -> (ReversiAIGame, Int, Int)? {
        let cloned = ReversiAIGame()
        cloned.board = self.board
        cloned.firstPlayer = (self.firstPlayer as! ReversiPlayer).clone()
        cloned.secondPlayer = (self.secondPlayer as! ReversiPlayer).clone()
        guard cloned.step(i, j) else {
            return nil
        }
        swap(&cloned.firstPlayer, &cloned.secondPlayer)
        return (cloned, i, j)
    }
    
    
    func generateChildren() -> [(ReversiAIGame, Int, Int)] {
        var children: [(ReversiAIGame, Int, Int)?] = []
        for i in 0...boardSize {
            for j in 0...boardSize {
                children.append(next(i, j))
            }
        }
        return children.flatMap{ $0 }
    }
 
}
