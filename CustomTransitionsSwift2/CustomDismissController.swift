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
    
    var viewPosition = ViewPosition()
    fileprivate var duration: TimeInterval
    fileprivate var presentedImage: UIImage
    
    init(withDuration duration: TimeInterval, presentedImage: UIImage, viewPosition: ViewPosition) {
        self.duration = duration
        self.presentedImage = presentedImage
        self.viewPosition = viewPosition
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
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
        let bounds = UIScreen.main.bounds
        let imageView = UIImageView(image: presentedImage)
        imageView.frame = CGRect(x: 5, y: Int(bounds.size.height/5), width: Int(bounds.size.width-10), height: Int(bounds.size.height*0.6))
        
        containerView.addSubview(lToVC.view)
        containerView.addSubview(imageView)
        containerView.sendSubview(toBack: lToVC.view)
        
        lFromVC.view.removeFromSuperview()
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            imageView.frame = CGRect(x: self.viewPosition.xPosition, y: self.viewPosition.yPosition+5, width: self.viewPosition.widht, height: self.viewPosition.height)
            
        }) { (finished) in
            
            imageView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
    
    
    
}
