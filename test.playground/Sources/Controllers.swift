import Foundation
import UIKit

public class ButtonController {
    private var button: UIButton
    @objc public func buttonTouched() {
        UIView.transition(with: self.button, duration: 0.5, options: .transitionCrossDissolve, animations: { self.button.isHighlighted = false }, completion: nil)
    }
    
    public init(button: UIButton){
        self.button = button
    }
}

public class InfoButtonController {
    private var view: UIView
    @objc public func buttonTouched() {
        let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        //present(alert, animated: true, completion: nil)
    }
    
    public init(view: UIView){
        self.view = view
    }
}
