import Foundation
import UIKit

public class Board: UIControl {
    
    required public init() {
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0.9315899611, green: 0.928239584, blue: 0.9350892901, alpha: 1)
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override public func draw(_ rect: CGRect) {
        let count = 8
        let dist = bounds.width / CGFloat(count)
        let pieceSize = dist * 0.8
        
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
        drawPiece(i: 3, j: 3, dist: dist, size: pieceSize, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor)
        drawPiece(i: 3, j: 4, dist: dist, size: pieceSize, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor)
        drawPiece(i: 4, j: 3, dist: dist, size: pieceSize, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor)
        drawPiece(i: 4, j: 4, dist: dist, size: pieceSize, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor)

    }
    
    public func drawPiece(i: Int, j: Int, dist: CGFloat, size: CGFloat, color: CGColor) {
        let p = CGPoint(x: CGFloat(i) * dist + (dist - size) / 2, y: CGFloat(j) * dist + (dist - size) / 2)
        let piece = CAShapeLayer()
        piece.fillColor = color
        piece.shadowRadius = 3
        piece.shadowOpacity = 0.5
        piece.shouldRasterize = true
        piece.path = CGPath(ellipseIn: CGRect(x: p.x, y: p.y, width: size, height: size), transform: nil)
        layer.addSublayer(piece)
    }
}
