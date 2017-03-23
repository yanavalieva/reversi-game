import Foundation
import UIKit

public class GameController : UIViewController {
    
    private let reversiLabel = UILabel()
    private let playgrLabel = UILabel()
    private let infoButton = UIButton(type: .infoLight)
    private let playButton = Button(label: "Play!")
    private let demoButton = Button(label: "Demo")
    private let modeLabel = UILabel()
    private let switchAI = UISwitch()
    private var game : ReversiGame?
    
    public var gameBoard : Board!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        let offset = 30
        let width = 500
        let height = 650
        let field = 100
        let clr = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0.580, 0.000, 0.827, 1.0])
        
        view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        reversiLabel.frame = CGRect(x: offset, y: offset, width: 100, height: 40)
        reversiLabel.text = "Reversi"
        reversiLabel.font = UIFont(name: "GillSans", size: 30)
        reversiLabel.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
        playgrLabel.frame = CGRect(x: offset + Int(reversiLabel.frame.width), y: offset, width: 135, height: 40)
        playgrLabel.text = "Playground"
        playgrLabel.font = UIFont(name: "GillSans", size: 30)
        playgrLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        infoButton.frame = CGRect(x: offset + Int(reversiLabel.frame.width) + Int(playgrLabel.frame.width), y: offset, width: 40, height: 40)
        infoButton.tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        infoButton.addTarget(self, action: #selector(infoTouched), for: .touchUpInside)
        
        gameBoard = Board(frame: CGRect(x: offset, y: offset + 10 + Int(reversiLabel.frame.height), width: width - offset * 2, height: width - offset * 2))
        gameBoard.addTarget(self, action: #selector(boardTouched), for: .touchUpInside)
        
        playButton.frame = CGRect(x: offset * 2, y: height - (field + offset) / 2 - 60 / 2, width: 120, height: 60)
        playButton.setTitle("Play!", for: .normal)
        playButton.setBackgroundImage(createImage(size: playButton.frame.size, color: clr!), for: .highlighted)
        playButton.addTarget(self, action: #selector(playTouched(sender:)), for: .touchUpInside)
        
        demoButton.frame = CGRect(x: offset * 3 + 120, y: height - (field + offset) / 2 - 60 / 2, width: 120, height: 60)
        demoButton.setTitle("Demo", for: .normal)
        demoButton.setBackgroundImage(createImage(size: playButton.frame.size, color: clr!), for: .highlighted)
        demoButton.addTarget(self, action: #selector(demoTouched(sender:)), for: .touchUpInside)
        
        modeLabel.frame = CGRect(x: width - offset * 3 - Int(UISwitch().bounds.width), y: height - (field + offset) / 2 - 20 / 2, width: 40, height: 20)
        modeLabel.text = "AI"
        modeLabel.font = UIFont(name: "GillSans", size: 20)
        modeLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        switchAI.frame = CGRect(origin: CGPoint(x: width - offset * 2 - Int(UISwitch().bounds.width), y: height - (field + offset) / 2 - Int(UISwitch().bounds.height) / 2), size: UISwitch().bounds.size)
        switchAI.tintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        switchAI.onTintColor = switchAI.tintColor
        
        view.addSubview(reversiLabel)
        view.addSubview(playgrLabel)
        view.addSubview(infoButton)
        view.addSubview(gameBoard)
        view.addSubview(playButton)
        view.addSubview(demoButton)
        view.addSubview(modeLabel)
        view.addSubview(switchAI)
    }
    
    @objc private func demoTouched(sender: Button) {
        buttonTouched(sender: sender, other: playButton, usual: ReversiGame(), smart: ReversiAIGame())
    }
    
    @objc private func playTouched(sender: Button) {
        buttonTouched(sender: sender, other: demoButton, usual: ReversiInteractiveGame(), smart: ReversiInteractiveAIGame())
    }
    
    @objc private func infoTouched() {
        showMessage(title: "title", message: "message", button: "button")
    }
    
    @objc public func boardTouched() {
        guard let p = gameBoard.touchLocation else {
            return
        }
        game?.humanStartsTurn(i: p.1, j: p.0)
    }
    
    public func showMessage(title: String, message: String, button: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: button, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func buttonTouched(sender: Button, other: Button, usual: ReversiGame, smart: ReversiGame) {
        if sender.titleLabel?.text == sender.label {
            sender.setTitle("Reset", for: .normal)
            switchAI.isEnabled = false
            other.isEnabled = false
            game = switchAI.isOn ? smart : usual
            DispatchQueue.global().async {
                if let game = self.game {
                    game.delegate = ReversiGameTracker(scene: self)
                    game.play()
                }
            }
        } else {
            sender.setTitle(sender.label, for: .normal)
            game?.stop()
            other.isEnabled = true
            switchAI.isEnabled = true
        }
        UIView.transition(with: sender, duration: 0.5, options: .transitionCrossDissolve, animations: { sender.isHighlighted = false }, completion: nil)
        
    }
}
