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
        guard DistortionLayer.isCustomAnimKey(event)
            else { return super.action(forKey: event) }
        
        guard let action = super.action(forKey: #keyPath(backgroundColor)) as? CAAnimation,
            let animation: CABasicAnimation = (action.copy() as? CABasicAnimation) else {
                setNeedsDisplay()
                return nil
        }
        
        if let presentationLayer = presentation() {
            animation.fromValue = presentationLayer.distortion
        }
        animation.keyPath = event
        animation.toValue = nil
        return animation
    }
}
