import UIKit
//import SwiftUI

public final class SheetTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    let transition = SheetTransition()

    public func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        UIPresentationController(presentedViewController: presented, presenting: presenting)
    }

    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        transition.wantsInteractiveStart = false
        return transition
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if transition.isPresenting {
            transition.wasDismissedReally = false
        }

        if !transition.isPresenting, transition.wasDismissedReally {
            transition.isMovingBack = true
        }

        transition.isPresenting = false
        return transition
    }

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        transition.isPresenting = false
        transition.wasDismissedReally = transition.isMovingBack
            ? false
            : true
        return transition
    }
}
