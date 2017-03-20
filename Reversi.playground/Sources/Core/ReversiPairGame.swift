import Foundation

public class ReversiPairGame: ReversiGame {
    
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
            //humanMakesTurn()
        }
        end()
    }
    
    public func humanMakesTurn() {}
}
