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
        print(viewPosition)

        
        
        
        
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)
        
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController!)
        
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        
        guard let lFromVC = fromViewController,
            let lToVC = toViewController
            else {return }
        
        let snapShotView = lFromVC.view.snapshotView(afterScreenUpdates: false)
        snapShotView?.frame = lFromVC.view.frame
        snapShotView?.backgroundColor = UIColor.black
        snapShotView?.isOpaque = false

        lToVC.view.frame = finalFrameForVC.offsetBy(dx:0, dy: bounds.size.height)
        
        let imagesView = UIImageView(image: presentedImage)
        imagesView.frame = CGRect(x: viewPosition.xPosition, y: viewPosition.yPosition, width: viewPosition.widht, height: viewPosition.height)
        
        containerView.addSubview(snapShotView!)
        containerView.addSubview(lToVC.view)
        containerView.addSubview(imagesView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            fromViewController?.view.removeFromSuperview()
            containerView.backgroundColor = UIColor.black
            imagesView.frame = CGRect(x: 5, y: Int(bounds.size.height/5), width: Int(bounds.size.width-10), height: Int(bounds.size.height*0.6))
            snapShotView?.alpha = 0.05
            
        }) { (finished) in
            transitionContext.completeTransition(true)
            lToVC.view.frame = finalFrameForVC
            imagesView.removeFromSuperview()
            //UIApplication.shared.keyWindow!.addSubview((toViewController?.view)!)
            
        }
        
    }
}
