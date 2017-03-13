import Foundation

public class ReversiAIGame : ReversiGame {
 
    public override func makeTurn() {
        let children = generateChildren()
        guard children.count > 0 else {
            delegate?.player(firstPlayer!, didTakeAction: .skipTurn)
            return
        }
        var maxSquare = (0, 0)
        var maxHeur = -Double.infinity
        for child in children {
            let h = child.0.alphaBeta(
                alpha: -Double.infinity, beta: Double.infinity, depth: 1)
            if h > maxHeur {
                maxHeur = h
                maxSquare = (child.1, child.2)
            }
        }
        if step(maxSquare.0, maxSquare.1) {
            delegate?.player(firstPlayer!, didTakeAction:
                .move(square: (maxSquare.0, maxSquare.1), game: self))
        }
    }

    
    private let priority: [Double] = [
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
                h += priority[i]
            } else {
                
                h -= board[i] == secondPlayer?.color ? priority[i] : 0
            }
        }
        return h / 64.0 * Double((firstPlayer?.score)!)
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
        return 0
    }
    
    func next(_ i: Int, _ j: Int) -> (ReversiAIGame, Int, Int)? {
        let cloned = ReversiAIGame()
        cloned.board = self.board
        cloned.firstPlayer = (self.firstPlayer as! ReversiPlayer).clone()
        cloned.secondPlayer = (self.secondPlayer as! ReversiPlayer).clone()
        guard cloned.step(i, j) else {
            return nil
        }
        swap(&firstPlayer, &secondPlayer)
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
