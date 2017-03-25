import Foundation

public class ReversiPlayer: Player {
    public let name: String
    public var score: Int
    public var color: PlayColor
    
    public init(name: String, color: PlayColor = .Empty, score: Int = 2) {
        self.name = name
        self.color = color
        self.score = score
    }
    
    public func clone() -> ReversiPlayer {
        return ReversiPlayer(name: self.name, color: self.color, score: self.score)
    }
    
    public func makeTurn(game: Game) -> (Int, Int)?{
        guard let g = game as? ReversiGame else {
            return nil
        }
        var squares = [(Int, Int)]()
        for i in 0..<g.boardSize {
            for j in 0..<g.boardSize {
                if g.elem(i, j) == PlayColor.Empty {
                    squares.append((i, j))
                }
            }
        }
        if squares.count == 0 {
            return nil
        }
        var ind = Int(arc4random()) % squares.count
        var (i, j) = squares[ind]
        while !g.step(player: self, i, j)
        {
            squares.remove(at: ind)
            if squares.count == 0 {
                return nil
            }
            ind = Int(arc4random()) % squares.count
            (i, j) = squares[ind]
        }
        return (i, j)
    }
}
