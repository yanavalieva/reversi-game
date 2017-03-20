import Foundation
import UIKit
public class Button: UIButton {
    
    required public init() {
        super.init(frame: .zero)
        let clr = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
        setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .highlighted)
        layer.borderWidth = 2
        layer.borderColor = clr
        titleLabel?.font = UIFont(name: "GillSans", size: 20)
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
