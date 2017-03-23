public protocol TurnbasedGame: TwoPlayersGame {
    var hasEnded: Bool { get }
    func start()
    func makeTurn()
    func end()
}


public protocol TurnbasedGameDelegate: GameDelegate {
    func highlightCell(i: Int, j: Int)
}

extension TurnbasedGameDelegate {
    public func gameDidEnd(_ game: Game) {
        let g = game as! TwoPlayersGame
        print("Whites: \(g.firstPlayer!.score)")
        print("Blacks: \(g.secondPlayer!.score)")
    }
}
