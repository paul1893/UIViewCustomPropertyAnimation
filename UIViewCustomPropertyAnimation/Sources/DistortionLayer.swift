import UIKit

class DistortionLayer: CAShapeLayer {
    @NSManaged var distortion: CGFloat
    
    override init() {
        super.init()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        if let layer = layer as? DistortionLayer {
            distortion = layer.distortion
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private class func isCustomAnimKey(_ key: String) -> Bool {
        return key == "distortion"
    }
    
    override class func needsDisplay(forKey key: String) -> Bool {
        if self.isCustomAnimKey(key) {
            return true
        }
        return super.needsDisplay(forKey: key)
    }
    
    override func action(forKey event: String) -> CAAction? {
        if DistortionLayer.isCustomAnimKey(event) {
            if let action = super.action(forKey: #keyPath(backgroundColor)) as? CAAnimation,
                let animation: CABasicAnimation = (action.copy() as? CABasicAnimation) {
                    animation.keyPath = event
                    if let pLayer = presentation() {
                        animation.fromValue = pLayer.distortion
                    }
                    animation.toValue = nil
                    return animation
            }
            setNeedsDisplay()
            return nil
        }
        
        return super.action(forKey: event)
    }
}
