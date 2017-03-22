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
            swap(&firstPlayer, &secondPlayer)
        }
        end()
    }
    
    public override func humanMakesTurn(i: Int, j: Int) {
        print(i, j)
        if !step(i, j) {
            delegate?.playerError("Wrong step")
            return
        }
        didMakeTurn = true
    }
}
