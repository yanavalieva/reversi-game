import Foundation

public class ReversiAIGame : ReversiGame {
    
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
            let s = -child.alphaBeta(alpha: -score, beta: -alpha, depth: depth - 1)
            score = s < score ? s : score
            if score <= alpha {
                return score
            }
        }
        return 0
    }
    
    func next(_ i: Int, _ j: Int) -> ReversiAIGame? {
        let cloned = ReversiAIGame()
        cloned.board = self.board
        cloned.firstPlayer = (self.firstPlayer as! ReversiPlayer).clone()
        cloned.secondPlayer = (self.secondPlayer as! ReversiPlayer).clone()
        guard cloned.step(i, j) else {
            return nil
        }
        swap(&firstPlayer, &secondPlayer)
        return cloned
    }
    
    func generateChildren() -> [ReversiAIGame] {
        var children: [ReversiAIGame?] = []
        for i in 0...boardSize {
            for j in 0...boardSize {
                children.append(next(i, j))
            }
        }
        return children.flatMap{ $0 }
    }
 
}
