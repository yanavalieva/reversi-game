import Foundation

public class ReversiInteractiveGame: ReversiGame {
    
    private var point : (Int, Int)?
    private var possibleSteps : [(Int, Int)] = []
    
    public var needPrompts : Bool = false
    
    public override func play() {
        guard let _ = firstPlayer, let _ = secondPlayer else {
            delegate?.playerError("No players!")
            return
        }
        start()
        while !hasEnded && !stopped {
            makeTurn()
            swap(&firstPlayer, &secondPlayer)
            if hasEnded {
                break
            }
            if !checkPossibleSteps() {
                delegate?.player(firstPlayer!, didTakeAction: .skipTurn)
                swap(&self.firstPlayer, &self.secondPlayer)
                continue
            }
            humanMakesTurn()
            possibleSteps.removeAll()
            let _ = DispatchQueue.main.sync {
                sleep(1)
            }
            swap(&self.firstPlayer, &self.secondPlayer)
        }
        if stopped {
            delegate?.gameDidStop()
        } else {
            end()
        }
    }
 
    public override func humanStartsTurn(i: Int, j: Int) {
        didMakeTurn = true
        point = (i, j)
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
        let _ = step(point!.0, point!.1)
        delegate?.player(firstPlayer!, didTakeAction: .move(square: (point!.0, point!.1), game: self))
    }
    
    
    private func checkPossibleSteps() -> Bool {
        for i in 0..<boardSize {
            for j in 0..<boardSize {
                if elem(i, j) == PlayColor.Empty {
                        let res = ReversiGame.directions.map{ checkNoStep(i, j, $0) }.reduce(false, { $0 || $1 })
                        if res {
                            possibleSteps.append((i, j))
                        }
                    }
                }
            }
        return possibleSteps.count > 0
    }
    
    private func checkNoStep(_ i: Int, _ j: Int, _ next: (Int, Int) -> (Int, Int)) -> Bool {
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
            if (board[cur] == secondPlayer!.color) {
                squares.append((ti, tj))
                deadRivals += 1
            } else if board[cur] == firstPlayer!.color && deadRivals > 0 {
                return true
            }
            else {
                return false
            }
        }
        return false
    }
}
