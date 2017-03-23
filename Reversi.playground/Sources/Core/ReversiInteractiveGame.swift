import Foundation

public class ReversiInteractiveGame: ReversiGame {
    
    override public func play() {
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
            humanMakesTurn()
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
    
    private var point : (Int, Int)?
    
    public override func humanStartsTurn(i: Int, j: Int) {
        didMakeTurn = true
        point = (i, j)
    }
    
    private func humanMakesTurn() {
        while(!didMakeTurn){
            if stopped {
                delegate?.gameDidStop()
                return
            }
        }
        didMakeTurn = false
        if !step(point!.0, point!.1) {
            delegate?.playerError("Incorrect step")
            humanMakesTurn()
        }
        delegate?.player(firstPlayer!, didTakeAction: .move(square: (point!.0, point!.1), game: self))
    }
}
