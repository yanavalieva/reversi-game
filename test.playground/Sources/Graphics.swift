import Foundation
import UIKit

public func drawDots(view: UIView) {
    let dotCount = 6
    for i in 0...dotCount {
        for j in 0..<dotCount {
            let dotSize = CGSize(width: view.bounds.width / CGFloat(dotCount), height: view.bounds.width / CGFloat(dotCount))
            let originX = view.bounds.origin.x + (0.15 + CGFloat(i) - CGFloat(j % 2) / 2) * dotSize.width
            let originY = view.bounds.origin.y + (0.15 + CGFloat(j)) * dotSize.height
            
            let dot = CAShapeLayer()
            dot.path = CGPath(ellipseIn: CGRect(x: originX, y: originY, width: dotSize.width / 2, height: dotSize.height / 2), transform: nil)
            
            dot.fillColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor
            dot.strokeColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor
            dot.shadowOpacity = 0.7
            view.layer.addSublayer(dot)
            
        }
    }
}

public func drawField(view: UIView) {
    let count = 6
    let dist = view.bounds.width / CGFloat(count)
    for i in 0...count {
            let sz = CGSize(width: CGFloat(1), height: view.bounds.height)
            let ox = view.bounds.origin.x + CGFloat(i) * dist
            let oy = view.bounds.origin.y
            let line = CAShapeLayer()
            line.bounds = CGRect(x: ox, y: oy, width: sz.width, height: sz.height)
            line.lineWidth = 1.0
            line.fillColor = UIColor.black.cgColor
            line.path = UIBezierPath(rect: line.bounds).cgPath
            view.layer.addSublayer(line)
        /*let dotSize = CGSize(width: view.bounds.width / CGFloat(dotCount), height: view.bounds.width / CGFloat(dotCount))
            let originX = view.bounds.origin.x + (0.15 + CGFloat(i) - CGFloat(j % 2) / 2) * dotSize.width
            let originY = view.bounds.origin.y + (0.15 + CGFloat(j)) * dotSize.height
            
            let dot = CAShapeLayer()
            dot.path = CGPath(ellipseIn: CGRect(x: originX, y: originY, width: dotSize.width / 2, height: dotSize.height / 2), transform: nil)
            
            dot.fillColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor
            dot.strokeColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor
            dot.shadowOpacity = 0.7
            view.layer.addSublayer(dot) */
    }
}
