import UIKit

/// An object that manages the transition animations for a `SheetPresentationController`.
final class SheetTransition: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {

    var isPresenting = true
    var isMovingBack = false
    var wasDismissedReally = false

    private var dismissAnimator: UIViewPropertyAnimator?
    private var presentationAnimator: UIViewPropertyAnimator?
    private let animationDuration: TimeInterval = 0.75

    var dismissFractionComplete: CGFloat {
        dismissAnimator?.fractionComplete ?? .zero
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        interruptibleAnimator(using: transitionContext).startAnimation()
    }

    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        if isPresenting {
            return presentationAnimator ?? presentationInterruptibleAnimator(using: transitionContext)
        } else {
            return dismissAnimator ?? dismissInterruptibleAnimator(using: transitionContext)
        }
    }

    private func presentationInterruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let toView = transitionContext.view(forKey: .to) else {
            return UIViewPropertyAnimator()
        }

        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), dampingRatio: 0.9)
        presentationAnimator = animator

        toView.frame = transitionContext.finalFrame(for: toViewController)
        toView.frame.origin.x = transitionContext.containerView.frame.minX

        transitionContext.containerView.addSubview(toView)

        animator.addAnimations {
            toView.frame = transitionContext.finalFrame(for: toViewController)
        }

        animator.addCompletion { position in
            if case .end = position {
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                return
            }

            transitionContext.completeTransition(false)
        }

        animator.addCompletion { [weak self] _ in
            self?.presentationAnimator = nil
        }

        return animator
    }

    private func dismissInterruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        guard let fromView = transitionContext.view(forKey: .from) else {
            return UIViewPropertyAnimator()
        }

        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), dampingRatio: 0.9)
        dismissAnimator = animator

        animator.addAnimations { [weak self] in
            if self?.isMovingBack == true {
                fromView.frame.origin.x = 0
                self?.isMovingBack = false
            } else {
                fromView.frame.origin.x = fromView.frame.size.width * 0.8
            }
        }

        animator.addCompletion { position in
            transitionContext.completeTransition(false)
        }

        animator.addCompletion { [weak self] _ in
            self?.dismissAnimator = nil
        }

        return animator
    }
}
