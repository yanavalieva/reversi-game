import Foundation

public class ReversiInteractiveGame: ReversiGame {
    
    override public func play() {
        guard let _ = firstPlayer, let _ = secondPlayer else {
            delegate?.playerError("No players!")
            return
        }
        start()
        while !hasEnded {
            makeTurn()
            swap(&firstPlayer, &secondPlayer)
            if hasEnded {
                break
            }
            while(!didMakeTurn){ }
            didMakeTurn = false
            
            if !step(point!.0, point!.1) {
                delegate?.playerError("Incorrect step")
                return
            }
            delegate?.player(firstPlayer!, didTakeAction: .move(square: ((point?.0)!, (point?.1)!), game: self))
            
            let _ = DispatchQueue.main.sync {
                sleep(1)
            }
            swap(&self.firstPlayer, &self.secondPlayer)
        }
        end()
    }
    
    private var point : (Int, Int)?
    
    public override func humanMakesTurn(i: Int, j: Int) {
        didMakeTurn = true
        point = (i, j)
    }
}
