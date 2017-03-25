import Foundation
import UIKit
public class Button: UIButton {
    
    public var label: String = ""
    
    required public init(label: String) {
        super.init(frame: .zero)
        setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .highlighted)
        setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .disabled)
        layer.borderWidth = 2
        layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
        titleLabel?.font = UIFont(name: "GillSans", size: 20)
        self.label = label
        setTitle(label, for: .normal)
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}

public func createImage(size: CGSize, color: CGColor) -> UIImage {
    let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context!.setFillColor(color)
    context!.fill(rect)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return img!
}
