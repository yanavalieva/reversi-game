# Reversi-game Playground
### WWDC'17 Scholarship winner  
***Reversi (Othello)** is a strategy board game for two players, played on an 8×8 uncheckered board. There are sixty-four identical game pieces called disks (often spelled "discs"), which are light on one side and dark on the other. Players take turns placing disks on the board with their assigned color facing up. During a play, any disks of the opponent's color that are in a straight line and bounded by the disk just placed and another disk of the current player's color are turned over to the current player's color. The object of the game is to have the majority of disks turned to display your color when the last playable empty square is filled. (from Wikipedia)*  

### Implementation: 
I implemented an interactive Reversi-game (Othello-game) as my Swift Playground. 
I used UIKit-framework to create concise user-friendly interface. The entire graphical component is realized using Core Graphics and QuartzCore frameworks. The main part of my Playground is a set of classes and protocols that implements Reversi-gameplay. 
Logic of base game (computer vs. computer) is described in ```ReversiGame```-class. ```InteractiveReversiGame``` is a subclass of ```ReversiGame```. It represents an interactive game (human vs. computer). ReversiPlayer and SmartReversiPlayer classes implement player behavior. ReversiPlayer plays like a novice and chooses moves randomly from all possible. SmartReversiPlayer uses simple artificial intelligence algorithm – Alpha-beta pruning to select the next move. Heuristic that I used is based on dot product of the priorities of pieces’ locations on the game board and current locations of the pieces. Every location has its strategic advantage.   
**Press “Demo” button to see demonstration, how computer fights with itself. Press “Play” button to play with computer. You can switch on or switch off “intellect” of computer using AI-switch. Also, you can enable prompts-mode to show possible moves on the board.**

<p align="center">
  <img src="https://github.com/vJenny/mobile-development/blob/master/lab1/Reversi.playground/Resources/reversi.jpg" width="300">
</p>
 
