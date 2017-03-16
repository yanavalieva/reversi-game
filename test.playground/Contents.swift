import UIKit
import PlaygroundSupport

let offset = 30
let width = 500
let height = 600
let field = 100

let mainView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
mainView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

let gameBoard = Board(frame: CGRect(x: offset, y: offset, width: width - offset * 2, height: height - offset * 2 - field))
gameBoard.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

let playButton = Button(frame: CGRect(x: offset * 2, y: height - (field + offset) / 2 - 60 / 2, width: 120, height: 60))
playButton.setTitle("Play!", for: .normal)

let demoButton = Button(frame: CGRect(x: offset * 3 + 120, y: height - (field + offset) / 2 - 60 / 2, width: 120, height: 60))
demoButton.setTitle("Demo", for: .normal)

let modeLabel = UILabel(frame: CGRect(x: width - offset * 3 - Int(UISwitch().bounds.width), y: height - (field + offset) / 2 - 20 / 2, width: 40, height: 20))
modeLabel.text = "AI"
modeLabel.font = UIFont(name: "GillSans", size: 20)
modeLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

let switchAI = UISwitch(frame: CGRect(origin: CGPoint(x: width - offset * 2 - Int(UISwitch().bounds.width), y: height - (field + offset) / 2 - Int(UISwitch().bounds.height) / 2), size: UISwitch().bounds.size))
switchAI.tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
switchAI.onTintColor = switchAI.tintColor

mainView.addSubview(gameBoard)
mainView.addSubview(playButton)
mainView.addSubview(demoButton)
mainView.addSubview(modeLabel)
mainView.addSubview(switchAI)
PlaygroundPage.current.liveView = mainView

