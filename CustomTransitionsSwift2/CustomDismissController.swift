//
//  CustomDismissController.swift
//  CustomTransitionsSwift2
//
//  Created by Ildar Zalyalov on 08.04.17.
//  Copyright © 2017 ru.itisIosLab. All rights reserved.
//

import Foundation
import UIKit

class CustomDismissController: NSObject, UIViewControllerAnimatedTransitioning  {
   
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController!)
        
        let containerView = transitionContext.containerView
        
        
        guard let lFromVC = fromViewController,
            let lToVC = toViewController
            else { return }
        
        lToVC.view.frame = finalFrameForVC
        lToVC.view.alpha = 0.5
        
        containerView.addSubview(lToVC.view)
        containerView.sendSubview(toBack: lToVC.view)
        
        let snapShotView = lFromVC.view.snapshotView(afterScreenUpdates: false)
        snapShotView?.frame = lFromVC.view.frame
        containerView.addSubview(snapShotView!)
        
        lFromVC.view.removeFromSuperview()
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            
            lToVC.view.alpha = 1.0
            snapShotView?.frame = lFromVC.view.frame.insetBy(dx: lFromVC.view.frame.width / 2, dy:lFromVC.view.frame.height/2)
            
        }) { (finished) in
            
            snapShotView?.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}
