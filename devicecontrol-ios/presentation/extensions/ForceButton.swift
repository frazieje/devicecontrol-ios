import UIKit

enum ForceButtonType: Int {
    case Shadow = 0
    case Scale = 1
}

class ForceButton: UIButton {
    
    private let maxForceValue: CGFloat = 6.6
    
    var shadowColor: UIColor = .lightGray
    var shadowOpacity: Float = 0.8
    var maxShadowOffset: CGSize = CGSize(width: 6.6, height: 6.6)
    var maxShadowRadius: CGFloat = 10.0
    var forceButtonType: ForceButtonType = .Scale
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        shadowWithAmount(amount: 0.0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        handleForceWithTouches(touches: touches)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        handleForceWithTouches(touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        switch forceButtonType {
        case .Shadow:
            shadowWithAmount(amount: 0.0)
        case .Scale:
            scaleWithAmount(amount: 0.0)
        }
    }
    
    func handleForceWithTouches(touches: Set<UITouch>) {
        if touches.count != 1 {
            return
        }
        guard let touch = touches.first else {
            return
        }
        switch forceButtonType {
        case .Shadow:
            shadowWithAmount(amount: touch.force)
        case .Scale:
            scaleWithAmount(amount: touch.force)
        }
    }
    
    func shadowWithAmount(amount: CGFloat) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        let widthFactor = maxShadowOffset.width/maxForceValue
        let heightFactor = maxShadowOffset.height/maxForceValue
        layer.shadowOffset = CGSize(width: maxShadowOffset.width - amount * widthFactor,
                                    height: maxShadowOffset.height - amount * heightFactor)
        layer.shadowRadius = maxShadowRadius - amount
    }
    
    func scaleWithAmount(amount: CGFloat) {
        layer.transform = CATransform3DMakeScale(1 + amount/100, 1 + amount/100, 1)
    }
}
