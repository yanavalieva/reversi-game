import UIKit
import PlaygroundSupport

class Controller {
    let message: String!
    let label: UILabel!
    @objc func buttonTouched() {
        label.text = message
    }
    
    init(with message: String, for label: UILabel){
        self.message = message
        self.label = label
    }
}

let offset = 30
let width = 500
let height = 600
let field = 100

let mainView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
mainView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)

let gameBoard = MyControl(frame: CGRect(x: offset, y: offset, width: width - offset * 2, height: height - offset * 2 - field))
gameBoard.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)

let playButton = UIButton(type: .system)
playButton.frame = CGRect(x: offset * 2, y: height - (field + offset) / 2 - 60 / 2, width: 120, height: 60)
playButton.setTitle("Play!", for: .normal)
playButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
playButton.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
playButton.titleLabel?.font = UIFont(name: "GillSans", size: 20)

let demoButton = UIButton(type: .system)
demoButton.frame = CGRect(x: offset * 3 + 120, y: height - (field + offset) / 2 - 60 / 2, width: 120, height: 60)
demoButton.setTitle("Demo", for: .normal)
demoButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
demoButton.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
demoButton.titleLabel?.font = UIFont(name: "GillSans", size: 20)

let modeLabel = UILabel(frame: CGRect(x: width - offset * 3 - Int(UISwitch().bounds.width), y: height - (field + offset) / 2 - 20 / 2, width: 40, height: 20))
modeLabel.text = "AI"
modeLabel.font = UIFont(name: "GillSans", size: 20)
modeLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

let switchAI = UISwitch(frame: CGRect(origin: CGPoint(x: width - offset * 2 - Int(UISwitch().bounds.width), y: height - (field + offset) / 2 - Int(UISwitch().bounds.height) / 2), size: UISwitch().bounds.size))
switchAI.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
switchAI.onTintColor = switchAI.tintColor

mainView.addSubview(gameBoard)
mainView.addSubview(playButton)
mainView.addSubview(demoButton)
mainView.addSubview(modeLabel)
mainView.addSubview(switchAI)
PlaygroundPage.current.liveView = mainView
