import Foundation
import UIKit

public class Board: UIControl {
    
    private var count = 8
    private var dist : CGFloat = 0
    private var pieceSize : CGFloat = 0
    
    public var pieces : [CAShapeLayer?] = []
    
    required public init() {
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0.9315899611, green: 0.928239584, blue: 0.9350892901, alpha: 1)
        pieces = Array(repeating: nil, count: count * count)
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let point = touch.location(in: self)
        let i = Int(point.x / dist)
        let j = Int(point.y / dist)
        drawPiece(i: i, j: j, color: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor)
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        count = 8
        dist = bounds.width / CGFloat(count)
        pieceSize = dist * 0.8
        
        for i in 1..<count {
            let line = CAShapeLayer()
            let linePath = UIBezierPath()
            let offset = dist * CGFloat(i)
            linePath.move(to: CGPoint(x: offset, y: 0))
            linePath.addLine(to: CGPoint(x: offset, y: bounds.height))
            linePath.move(to: CGPoint(x: 0, y: offset))
            linePath.addLine(to: CGPoint(x: bounds.width, y: offset))
            line.path = linePath.cgPath
            line.opacity = 1.0
            line.strokeColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
            layer.addSublayer(line)
        }
        drawPiece(i: 3, j: 3, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor)
        drawPiece(i: 3, j: 4, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor)
        drawPiece(i: 4, j: 3, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor)
        drawPiece(i: 4, j: 4, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor)
        
    }
    
    public func drawPiece(i: Int, j: Int, color: CGColor) {
        let id = i * count + j
        if pieces[id] == nil {
            let p = CGPoint(x: CGFloat(i) * dist + (dist - pieceSize) / 2, y: CGFloat(j) * dist + (dist - pieceSize) / 2)
            pieces[id] = CAShapeLayer()
            pieces[id]!.fillColor = color
            pieces[id]!.shadowRadius = 3
            pieces[id]!.shadowOpacity = 0.5
            pieces[id]!.shouldRasterize = true
            pieces[id]!.path = CGPath(ellipseIn: CGRect(x: p.x, y: p.y, width: pieceSize, height: pieceSize), transform: nil)
            layer.addSublayer(pieces[id]!)
            return
        } else {
            pieces[id]!.fillColor = color
        }
    }
}
