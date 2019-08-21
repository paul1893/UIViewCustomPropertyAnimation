import Foundation
import UIKit

class DistortionView: UIView {
    var distortion: CGFloat {
        set {
            if let layer = layer as? DistortionLayer {
                layer.distortion = newValue
            }
        }
        get {
            if let layer = layer as? DistortionLayer {
                return layer.distortion
            }
            return 0.0
        }
    }
    
    override class var layerClass: AnyClass {
        return DistortionLayer.self
    }
    
    override func display(_ layer: CALayer) {
        if let pLayer = layer.presentation() as? DistortionLayer {
        
            if let castLayer  = layer as? CAShapeLayer{
                let width = frame.width
                let height = frame.height
                let distortionValue = (max(width, height)/8) * pLayer.distortion
                let x0 = CGPoint(x: 0, y: 0)
                let p0 = CGPoint(x: width/2, y: 0 + distortionValue)
                let x1 = CGPoint(x: width, y: 0)
                let p1 = CGPoint(x: width - distortionValue, y: height/2)
                let x2 = CGPoint(x: width, y: height)
                let p2 = CGPoint(x: width/2, y: height - distortionValue)
                let x3 = CGPoint(x: 0, y: height)
                let p3 = CGPoint(x: 0 + distortionValue, y: height/2)
                
                let path = UIBezierPath()
                path.move(to: x0)
                path.addQuadCurve(to: x1, controlPoint: p0)
                path.addQuadCurve(to: x2, controlPoint: p1)
                path.addQuadCurve(to: x3, controlPoint: p2)
                path.addQuadCurve(to: x0, controlPoint: p3)
                path.close()
                
                let maskShape = CAShapeLayer()
                maskShape.path = path.cgPath
                
                castLayer.mask = maskShape
            }
        }
    }
}
