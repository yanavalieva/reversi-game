import Foundation
import UIKit

public class GameController : UIViewController {
    
    private let reversiLabel = UILabel()
    private let playgrLabel = UILabel()
    private let playButton = Button(label: "Play!")
    private let demoButton = Button(label: "Demo")
    private let modeLabel = UILabel()
    private let promptLabel = UILabel()
    private let switchAI = UISwitch()
    private let switchPrompts = UISwitch()
    private let stateLabel = UILabel()
    private var game : ReversiGame?
    
    public var gameBoard : Board!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        let offset = 10
        let width = 375
        let height = 667
        let clr = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0.580, 0.000, 0.827, 1.0])
        
        view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        reversiLabel.frame = CGRect(x: offset, y: offset * 3, width: 100, height: 40)
        reversiLabel.text = "Reversi"
        reversiLabel.font = UIFont(name: "GillSans", size: 30)
        reversiLabel.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
        playgrLabel.frame = CGRect(x: offset + Int(reversiLabel.frame.width), y: offset * 3, width: 135, height: 40)
        playgrLabel.text = "Playground"
        playgrLabel.font = UIFont(name: "GillSans", size: 30)
        playgrLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        gameBoard = Board(frame: CGRect(x: offset, y: offset * 5 + Int(reversiLabel.frame.height), width: width - offset * 2, height: width - offset * 2))
        gameBoard.addTarget(self, action: #selector(boardTouched), for: .touchUpInside)
        
        var tmp = Int(gameBoard.frame.height) + offset * 7 + Int(reversiLabel.frame.height)
        stateLabel.frame = CGRect(x: offset, y: tmp, width: width - offset * 2, height: 50)
        stateLabel.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        stateLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        stateLabel.textAlignment = .center
        stateLabel.font = UIFont(name: "GillSans", size: 20)
        stateLabel.text = "Let's play!"
        
        tmp += 50 + offset * 2
        playButton.frame = CGRect(x: offset, y: tmp, width: (width - offset * 3) / 2, height: 50)
        playButton.setTitle("Play!", for: .normal)
        playButton.setBackgroundImage(createImage(size: playButton.frame.size, color: clr!), for: .highlighted)
        playButton.addTarget(self, action: #selector(playTouched(sender:)), for: .touchUpInside)
        
        demoButton.frame = CGRect(x: offset * 2 + Int(playButton.bounds.width), y: tmp, width: (width - offset * 3) / 2, height: 50)
        demoButton.setTitle("Demo", for: .normal)
        demoButton.setBackgroundImage(createImage(size: playButton.frame.size, color: clr!), for: .highlighted)
        demoButton.addTarget(self, action: #selector(demoTouched(sender:)), for: .touchUpInside)
        
        tmp += 50
        tmp = height - (height - tmp) / 2
        var st = offset + (width / 2 - offset - 40 - Int(UISwitch().bounds.width)) / 2
        modeLabel.frame = CGRect(x: st, y: tmp - offset, width: 40, height: 20)
        modeLabel.text = "AI"
        modeLabel.font = UIFont(name: "GillSans", size: 20)
        modeLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        switchAI.frame = CGRect(origin: CGPoint(x: st + Int(modeLabel.bounds.width), y: tmp - Int(UISwitch().bounds.height / 2)), size: UISwitch().bounds.size)
        switchAI.tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        switchAI.onTintColor = switchAI.tintColor
        
        st = width / 2 + (width / 2 - offset - 80 - Int(UISwitch().bounds.width)) / 2
        promptLabel.frame = CGRect(x: st, y: tmp - offset, width: 80, height: 20)
        promptLabel.text = "Prompts"
        promptLabel.font = UIFont(name: "GillSans", size: 20)
        promptLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        switchPrompts.frame = CGRect(origin: CGPoint(x: st + Int(promptLabel.bounds.width), y: tmp - Int(UISwitch().bounds.height / 2)), size: UISwitch().bounds.size)
        switchPrompts.tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        switchPrompts.onTintColor = switchAI.tintColor
        
        view.addSubview(reversiLabel)
        view.addSubview(playgrLabel)
        view.addSubview(gameBoard)
        view.addSubview(stateLabel)
        view.addSubview(playButton)
        view.addSubview(demoButton)
        view.addSubview(modeLabel)
        view.addSubview(switchAI)
        view.addSubview(promptLabel)
        view.addSubview(switchPrompts)
    }
    
    public func updateState(message: String) {
        stateLabel.text = message
    }
    
    @objc private func demoTouched(sender: Button) {
        let g = ReversiGame()
        if switchAI.isOn {
            g.firstPlayer = SmartReversiPlayer(name: "Dark side", color: .Black, score: 2)
            g.secondPlayer = SmartReversiPlayer(name: "Light side", color: .White, score: 2)
        } else {
            g.firstPlayer = ReversiPlayer(name: "Dark side", color: .Black, score: 2)
            g.secondPlayer = ReversiPlayer(name: "Light side", color: .White, score: 2)
        }
        buttonTouched(sender: sender, other: playButton, g: g)
    }
    
    @objc private func playTouched(sender: Button) {
        let g = InteractiveReversiGame()
        if switchAI.isOn {
            g.firstPlayer = SmartReversiPlayer(name: "Computer", color: .Black, score: 2)
            g.secondPlayer = SmartReversiPlayer(name: "You", color: .White, score: 2)
        } else {
            g.firstPlayer = ReversiPlayer(name: "Computer", color: .Black, score: 2)
            g.secondPlayer = ReversiPlayer(name: "You", color: .White, score: 2)
        }
        g.needPrompts = switchPrompts.isOn
        buttonTouched(sender: sender, other: demoButton, g: g)
    }
    
    @objc private func boardTouched() {
        guard let p = gameBoard.touchLocation else {
            return
        }
        if let g = game as? InteractiveReversiGame {
            g.humanStartsTurn(i: p.1, j: p.0)
        }
    }
    
    private func buttonTouched(sender: Button, other: Button, g: ReversiGame) {
        if sender.titleLabel?.text == sender.label {
            sender.setTitle("Reset", for: .normal)
            switchAI.isEnabled = false
            other.isEnabled = false
            switchPrompts.isEnabled = false
            game = g
            DispatchQueue.global().async {
                if let game = self.game {
                    game.delegate = ReversiGameTracker(scene: self)
                    game.play()
                }
            }
        } else {
            sender.setTitle(sender.label, for: .normal)
            game?.stop()
            updateState(message: "Let's play!")
            other.isEnabled = true
            switchAI.isEnabled = true
            switchPrompts.isEnabled = true
            gameBoard.reset()
        }
        UIView.transition(with: sender, duration: 0.5, options: .transitionCrossDissolve, animations: { sender.isHighlighted = false }, completion: nil)
        
    }
}
