/*:
**Reversi (Othello)** is a strategy board game for two players, played on an 8×8 uncheckered board. There are sixty-four identical game pieces called disks (often spelled "discs"), which are light on one side and dark on the other. Players take turns placing disks on the board with their assigned color facing up. During a play, any disks of the opponent's color that are in a straight line and bounded by the disk just placed and another disk of the current player's color are turned over to the current player's color. The object of the game is to have the majority of disks turned to display your color when the last playable empty square is filled.
 
 ![PlayWithMe](reversi.jpg)
*/

/* import Foundation
let game: ReversiGame = ReversiAIGame()
game.delegate = ReversiGameTracker()
print(game)

var blackPlayer = ReversiPlayer(name: "James Moriarty")
var whitePlayer = ReversiPlayer(name: "Sherlock Holmes")

game.joinFirst(player: blackPlayer)
game.joinSecond(player: whitePlayer)

game.play() */

import UIKit
import PlaygroundSupport

let scene = GameController()
PlaygroundPage.current.liveView = scene.view




