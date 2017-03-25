import Foundation

public class InteractiveReversiGame: ReversiGame {
    
    private var point : (Int, Int)?
    private var possibleSteps : [(Int, Int)] = []
    public var didMakeTurn : Bool = false
    public var needPrompts : Bool = false
    
 
    public override func play() {
        while !hasEnded && !stopped {
            processStep(player: firstPlayer)
            if hasEnded || stopped {
                break
            }
            if !checkPossibleSteps() {
                delegate?.player(secondPlayer, didTakeAction: .skipTurn)
                continue
            }
            humanMakesTurn()
            possibleSteps.removeAll()
            let _ = DispatchQueue.main.sync {
                sleep(1)
            }
        }
        if stopped {
            delegate?.gameDidStop()
        } else {
            end()
        }
    }

    public func humanStartsTurn(i: Int, j: Int) {
        didMakeTurn = true
        point = (i, j)
    }
    
    private func checkPossibleSteps() -> Bool {
        for i in 0..<boardSize {
            for j in 0..<boardSize {
                if elem(i, j) == PlayColor.Empty {
                    let res = ReversiGame.directions.map{ checkNoStep(player: secondPlayer as! ReversiPlayer, other: firstPlayer as! ReversiPlayer, i, j, next: $0) }.reduce(false, { $0 || $1 })
                    if res {
                        possibleSteps.append((i, j))
                    }
                }
            }
        }
        return possibleSteps.count > 0
    }
    
    private func checkNoStep(player: ReversiPlayer, other: ReversiPlayer, _ i: Int, _ j: Int, next: (Int, Int) -> (Int, Int)) -> Bool {
        var deadRivals = 0
        var squares: [(Int, Int)] = []
        var ti = i, tj = j
        if (elem(ti, tj) != PlayColor.Empty) {
            return false
        }
        while (ti >= 0 && ti < boardSize && tj >= 0 && tj < boardSize) {
            (ti, tj) = next(ti, tj)
            let cur = index(ti, tj)
            if cur == -1 {
                return false
            }
            if (board[cur] == other.color) {
                squares.append((ti, tj))
                deadRivals += 1
            } else if board[cur] == player.color && deadRivals > 0 {
                return true
            }
            else {
                return false
            }
        }
        return false
    }
    
    private func humanMakesTurn() {
        if needPrompts {
            for step in possibleSteps {
                delegate?.highlightCell(i: step.0, j: step.1)
            }
        }
        while(!didMakeTurn){
            if stopped {
                delegate?.gameDidStop()
                return
            }
        }
        didMakeTurn = false
        if !possibleSteps.contains(where: { $0.0 == point!.0 && $0.1 == point!.1 }) {
            delegate?.playerError("Incorrect step")
            humanMakesTurn()
        }
        let _ = step(player: secondPlayer as! ReversiPlayer, point!.0, point!.1)
        delegate?.player(secondPlayer, didTakeAction: .move(square: (point!.0, point!.1)))
    }
}
