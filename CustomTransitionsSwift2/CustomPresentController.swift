//
//  CustomPresentController.swift
//  CustomTransitionsSwift2
//
//  Created by Ildar Zalyalov on 08.04.17.
//  Copyright © 2017 ru.itisIosLab. All rights reserved.
//

import Foundation
import UIKit

class CustomPresentController: NSObject, UIViewControllerAnimatedTransitioning {
    var viewPosition = ViewPosition()
    
    fileprivate var duration: TimeInterval
    fileprivate var presentedImageView: UIImageView
    
    init(withDuration duration: TimeInterval, presentedImageView:UIImageView) {
        self.duration = duration
        self.presentedImageView = presentedImageView
        
        super.init()
    }
    
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        print(viewPosition)
        
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)
        
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController!)
        
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        
        guard let lFromVC = fromViewController,
              let lToVC = toViewController
        else { return }
        
        lToVC.view.frame = finalFrameForVC.offsetBy(dx:0, dy: bounds.size.height)
        
        containerView.addSubview(lToVC.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveLinear, animations: { 
            

            lFromVC.view.alpha = 0.5
            lToVC.view.frame = finalFrameForVC
            
        }) { (finished) in
            transitionContext.completeTransition(true)
            lFromVC.view.alpha = 1.0
        }
    }
}
