import Foundation
import UIKit

public class Board: UIControl {
    
    private var count = 8
    private var dist : CGFloat = 0
    private var pieceSize : CGFloat = 0
    
    public var touchLocation : (Int, Int)?
    public var pieces : [CAShapeLayer?] = []
    
    required public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9315899611, green: 0.928239584, blue: 0.9350892901, alpha: 1)
        pieces = Array(repeating: nil, count: count * count)
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
            self.layer.addSublayer(line)
        }
        drawPiece(i: 3, j: 3, color: #colorLiteral(red: 0.976108253, green: 0.9726067185, blue: 0.9797653556, alpha: 1).cgColor)
        drawPiece(i: 3, j: 4, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor)
        drawPiece(i: 4, j: 3, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor)
        drawPiece(i: 4, j: 4, color: #colorLiteral(red: 0.976108253, green: 0.9726067185, blue: 0.9797653556, alpha: 1).cgColor)
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard touches.count > 0 && frame != .zero else {
            return
        }
        let touch = touches.first
        let point = touch!.location(in: self)
        let i = Int(point.x / dist)
        let j = Int(point.y / dist)
        touchLocation = (i, j)
    }
    
    public func reset() {
        for i in 0..<pieces.count {
            pieces[i]?.opacity = 0
        }
        drawPiece(i: 3, j: 3, color: #colorLiteral(red: 0.976108253, green: 0.9726067185, blue: 0.9797653556, alpha: 1).cgColor)
        drawPiece(i: 3, j: 4, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor)
        drawPiece(i: 4, j: 3, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor)
        drawPiece(i: 4, j: 4, color: #colorLiteral(red: 0.976108253, green: 0.9726067185, blue: 0.9797653556, alpha: 1).cgColor)
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
            pieces[id]!.shadowOffset = CGSize(width: 4, height: 4)
            pieces[id]!.path = CGPath(ellipseIn: CGRect(x: p.x, y: p.y, width: pieceSize, height: pieceSize), transform: nil)
            
            let spot = CAShapeLayer()
            spot.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            spot.shadowColor = #colorLiteral(red: 0.9962956309, green: 0.9927255511, blue: 1, alpha: 1).cgColor
            spot.opacity = 0.6
            spot.shadowRadius = 4
            spot.shadowOpacity = 1
            spot.shadowOffset = CGSize(width: 4, height: 3)
            spot.path = CGPath(ellipseIn: CGRect(x: p.x + 10, y: p.y + 10, width: 10, height: 10), transform: nil)
            
            pieces[id]!.addSublayer(spot)
            layer.addSublayer(pieces[id]!)
            self.setNeedsDisplay()
            return
        } else {
            pieces[id]!.opacity = 1
            pieces[id]!.fillColor = color
        }
    }
}
