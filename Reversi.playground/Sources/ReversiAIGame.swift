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
        for i in 0...board.count {
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
        return 0
    }
    
/* double Player::AlphaBeta(Board * board, double alpha, double beta, int depth, char player) const
 {
	if (depth == 0 || board->isFinished())
 return -Heuristic(board, player);
	auto score = beta;
	auto children = board->GenerateChildren(player);
	if (children.size() == 0) return -Heuristic(board, player);
	for (auto child : children)
	{
 auto s = -AlphaBeta(child, -score, -alpha, depth - 1, player == 'W' ? 'B' : 'W');
 score = s < score ? s : score;
 if (score <= alpha)
 return score;
	}
	return score;
 }*/
 
}
