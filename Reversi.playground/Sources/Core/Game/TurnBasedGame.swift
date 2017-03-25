public protocol TurnbasedGame: TwoPlayersGame {
    var hasEnded: Bool { get }
    func makeTurn()
    func end()
}
