import UIKit
import pop
import Firebase
import Alamofire

class SwipeableView: UIView {

    // MARK: Local Variables

    private var json: Any?
    static var beer = beerSetup(userId: "test", beerValue: [])

    var delegate: SwipeableViewDelegate?

    private weak var shadowView: UIView?

    var actualDirection: SwipeDirection?

    // MARK: Gesture Recognizer

    private var panGestureRecognizer: UIPanGestureRecognizer?

    private var panGestureTranslation: CGPoint = .zero

    private var tapGestureRecognizer: UITapGestureRecognizer?

    // MARK: Drag Animation Settings

    static var maximumRotation: CGFloat = 1.0

    static var rotationAngle: CGFloat = CGFloat(Double.pi) / 10.0

    static var animationDirectionY: CGFloat = 1.0

    static var swipePercentageMargin: CGFloat = 0.6

    // MARK: Card Finalize Swipe Animation

    static var finalizeSwipeActionAnimationDuration: TimeInterval = 0.8

    // MARK: Card Reset Animation

    static var cardViewResetAnimationSpringBounciness: CGFloat = 10.0

    static var cardViewResetAnimationSpringSpeed: CGFloat = 20.0

    static var cardViewResetAnimationDuration: TimeInterval = 0.2

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGestureRecognizers()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGestureRecognizers()
    }

    deinit {
        if let panGestureRecognizer = panGestureRecognizer {
            removeGestureRecognizer(panGestureRecognizer)
        }
        if let tapGestureRecognizer = tapGestureRecognizer {
            removeGestureRecognizer(tapGestureRecognizer)
        }
    }

    private func setupGestureRecognizers() {
        // Pan Gesture Recognizer
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(SwipeableView.panGestureRecognized(_:)))
        self.panGestureRecognizer = panGestureRecognizer
        addGestureRecognizer(panGestureRecognizer)

        // Tap Gesture Recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapRecognized(_:)))
        self.tapGestureRecognizer = tapGestureRecognizer
        addGestureRecognizer(tapGestureRecognizer)
    }

    // MARK: - Pan Gesture Recognizer

    @objc private func panGestureRecognized(_ gestureRecognizer: UIPanGestureRecognizer) {
        panGestureTranslation = gestureRecognizer.translation(in: self)

        switch gestureRecognizer.state {
        case .began:

            if dragDirection == .right {
                self.configureShadow(color: "g")
            } else if dragDirection == .left {
                self.configureShadow(color: "r")
            } else if dragDirection == .up {
                self.configureShadow(color: "b")
            }
            actualDirection = dragDirection
            let initialTouchPoint = gestureRecognizer.location(in: self)
            let newAnchorPoint = CGPoint(x: initialTouchPoint.x / bounds.width, y: initialTouchPoint.y / bounds.height)
            let oldPosition = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)
            let newPosition = CGPoint(x: bounds.size.width * newAnchorPoint.x, y: bounds.size.height * newAnchorPoint.y)
            layer.anchorPoint = newAnchorPoint
            layer.position = CGPoint(x: layer.position.x - oldPosition.x + newPosition.x, y: layer.position.y - oldPosition.y + newPosition.y)

            removeAnimations()
            layer.rasterizationScale = UIScreen.main.scale
            layer.shouldRasterize = true
            delegate?.didBeginSwipe(onView: self)
        case .changed:
            if actualDirection != dragDirection {
                self.shadowView?.removeFromSuperview()
                if dragDirection == .right {
                    self.configureShadow(color: "g")
                } else if dragDirection == .left {
                    self.configureShadow(color: "r")
                } else if dragDirection == .up {
                    self.configureShadow(color: "b")
                }
                actualDirection = dragDirection
            }
            let rotationStrength = min(panGestureTranslation.x / frame.width, SwipeableView.maximumRotation)
            let rotationAngle = SwipeableView.animationDirectionY * SwipeableView.rotationAngle * rotationStrength
            var transform = CATransform3DIdentity
            transform = CATransform3DRotate(transform, rotationAngle, 0, 0, 1)
            transform = CATransform3DTranslate(transform, panGestureTranslation.x, panGestureTranslation.y, 0)
            layer.transform = transform
        case .ended:
            self.shadowView?.removeFromSuperview()
            endedPanAnimation()
            layer.shouldRasterize = false
        default:
            self.shadowView?.removeFromSuperview()
            resetCardViewPosition()
            layer.shouldRasterize = false
        }
    }

    private var dragDirection: SwipeDirection? {
        let normalizedDragPoint = panGestureTranslation.normalizedDistanceForSize(bounds.size)
        return SwipeDirection.allDirections.reduce((distance: CGFloat.infinity, direction: nil), { closest, direction -> (CGFloat, SwipeDirection?) in
                let distance = direction.point.distanceTo(normalizedDragPoint)
                if distance < closest.distance {
                    return (distance, direction)
                }
                return closest
            }).direction
    }

    private var dragPercentage: CGFloat {
        guard let dragDirection = dragDirection else { return 0.0 }

        let normalizedDragPoint = panGestureTranslation.normalizedDistanceForSize(frame.size)
        let swipePoint = normalizedDragPoint.scalarProjectionPointWith(dragDirection.point)

        let rect = SwipeDirection.boundsRect

        if !rect.contains(swipePoint) {
            return 1.0
        } else {
            let centerDistance = swipePoint.distanceTo(.zero)
            let targetLine = (swipePoint, CGPoint.zero)

            return rect.perimeterLines
                .compactMap { CGPoint.intersectionBetweenLines(targetLine, line2: $0) }
                .map { centerDistance / $0.distanceTo(.zero) }
                .min() ?? 0.0
        }
    }

    private func endedPanAnimation() {
        if let dragDirection = dragDirection, dragPercentage >= SwipeableView.swipePercentageMargin {
            SwipeableView.beer.setId(value: (Auth.auth().currentUser?.uid.description)!)
            let translationAnimation = POPBasicAnimation(propertyNamed: kPOPLayerTranslationXY)
            translationAnimation?.duration = SwipeableView.finalizeSwipeActionAnimationDuration
            translationAnimation?.fromValue = NSValue(cgPoint: POPLayerGetTranslationXY(layer))
            translationAnimation?.toValue = NSValue(cgPoint: animationPointForDirection(dragDirection))
            layer.pop_add(translationAnimation, forKey: "swipeTranslationAnimation")

            if dragDirection == .right { SwipeableView.beer.appenValue(value: 1) }
            else if(dragDirection == .left) { SwipeableView.beer.appenValue(value: 0) }
            else { SwipeableView.beer.appenValue(value: 2) }
            let encodedData = try? JSONEncoder().encode(SwipeableView.beer)
            if let data = encodedData {
                json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            }
            if SwipeableView.beer.countBeer() == 9 {
                print("RESULT: \(json!)")
                let homeViewController = self.parentViewController().storyboard?.instantiateViewController(withIdentifier: "tabHome")
                self.parentViewController().present(homeViewController!, animated: true, completion: nil)
            }

            self.delegate?.didEndSwipe(onView: self)
        } else {
            resetCardViewPosition()
        }
    }

    private func animationPointForDirection(_ direction: SwipeDirection) -> CGPoint {
        let point = direction.point
        let animatePoint = CGPoint(x: point.x * 4, y: point.y * 4)
        let retPoint = animatePoint.screenPointForSize(UIScreen.main.bounds.size)
        return retPoint
    }

    private func resetCardViewPosition() {
        removeAnimations()

        // Reset Translation
        let resetPositionAnimation = POPSpringAnimation(propertyNamed: kPOPLayerTranslationXY)
        resetPositionAnimation?.fromValue = NSValue(cgPoint: POPLayerGetTranslationXY(layer))
        resetPositionAnimation?.toValue = NSValue(cgPoint: CGPoint.zero)
        resetPositionAnimation?.springBounciness = SwipeableView.cardViewResetAnimationSpringBounciness
        resetPositionAnimation?.springSpeed = SwipeableView.cardViewResetAnimationSpringSpeed
        resetPositionAnimation?.completionBlock = { _, _ in
            self.layer.transform = CATransform3DIdentity
        }
        layer.pop_add(resetPositionAnimation, forKey: "resetPositionAnimation")

        // Reset Rotation
        let resetRotationAnimation = POPBasicAnimation(propertyNamed: kPOPLayerRotation)
        resetRotationAnimation?.fromValue = POPLayerGetRotationZ(layer)
        resetRotationAnimation?.toValue = CGFloat(0.0)
        resetRotationAnimation?.duration = SwipeableView.cardViewResetAnimationDuration
        layer.pop_add(resetRotationAnimation, forKey: "resetRotationAnimation")
    }

    private func removeAnimations() {
        pop_removeAllAnimations()
        layer.pop_removeAllAnimations()
    }

    // MARK: - Tap Gesture Recognizer

    @objc private func tapRecognized(_ recognizer: UITapGestureRecognizer) {
        delegate?.didTap(view: self)
    }

    private func configureShadow(color: String) {
        let shadowView = UIView(frame: CGRect(x: SampleSwipeableCard.kInnerMargin,
            y: SampleSwipeableCard.kInnerMargin,
            width: bounds.width - (2 * SampleSwipeableCard.kInnerMargin),
            height: bounds.height - (2 * SampleSwipeableCard.kInnerMargin)))
        insertSubview(shadowView, at: 0)
        exchangeSubview(at: 0, withSubviewAt: 1)
        self.shadowView = shadowView
        self.applyShadow(width: CGFloat(0.0), height: CGFloat(0.0), color: color)
    }

    private func applyShadow(width: CGFloat, height: CGFloat, color: String) {
        if let shadowView = shadowView {
            let shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 16.0)
            shadowView.layer.masksToBounds = false
            shadowView.layer.shadowRadius = 24.0
            shadowView.layer.shadowOffset = CGSize(width: width, height: height)
            shadowView.layer.shadowOpacity = 1
            shadowView.layer.shadowPath = shadowPath.cgPath
            let green = UIColor(red:0.46, green:0.84, blue:0.00, alpha:1.0)
            let red = UIColor(red:0.95, green:0.25, blue:0.29, alpha:1.0)
            let blue = UIColor(red:0.00, green:0.50, blue:1.00, alpha:1.0)
            if color == "g" { shadowView.layer.shadowColor = green.cgColor }
            if color == "r" { shadowView.layer.shadowColor = red.cgColor  }
            if color == "b" { shadowView.layer.shadowColor = blue.cgColor  }
        }
    }

}

extension UIView
    {
        //Get Parent View Controller from any view
        func parentViewController() -> UIViewController {
            var responder: UIResponder? = self
            while !(responder is UIViewController) {
                responder = responder?.next
                if nil == responder {
                    break
                }
            }
            return (responder as? UIViewController)!
        }
}
