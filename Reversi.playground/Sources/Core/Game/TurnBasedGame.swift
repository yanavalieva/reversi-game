public protocol TurnbasedGame: TwoPlayersGame {
    var hasEnded: Bool { get }
    func start()
    func makeTurn()
    func end()
}
