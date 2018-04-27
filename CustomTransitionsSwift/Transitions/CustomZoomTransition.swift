//
//  CustomZoomTransition.swift
//  CustomTransitionsSwift
//
//  Created by Азат Алекбаев on 22.04.2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

import UIKit

class CustomZoomTransition: NSObject, UIViewControllerAnimatedTransitioning {
    

    var beganPresenting:Bool = false
    var selectedCellFrame: CGRect?
    var cell: UICollectionViewCell?
    var durationOfAnimation = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return durationOfAnimation
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        var detailImageView: UIImageView!
        var backgroundView: UIView!
        let zeroAlpha: CGFloat = 0
        let oneAlpha:CGFloat = 1
        
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let toViewController = transitionContext.viewController(forKey: .to)
        else { return }
        
        guard let toView = toViewController.view,
              let fromView = fromViewController.view
        else { return }
        
        if let detailViewController = toViewController as? DetailViewController {
            detailImageView = detailViewController.detailImageView
            backgroundView = detailViewController.backgroundView
        } else if let detailViewController = fromViewController as? DetailViewController {
            detailImageView = detailViewController.detailImageView
            backgroundView = detailViewController.backgroundView
            
        }
        if beganPresenting {
            containerView.addSubview(toView)
            containerView.sendSubview(toBack: toView)
        } else {
            guard let selectedCell = self.cell else { return }
            toView.alpha = zeroAlpha
            containerView.addSubview(toView)
            containerView.addSubview(selectedCell)
        }
        UIView.animate(withDuration: durationOfAnimation, animations: { [weak self] in
            guard let strongSelf = self else { return }
            if strongSelf.beganPresenting {
                backgroundView.alpha = zeroAlpha
                guard let selectedCellFrame = strongSelf.selectedCellFrame else { return }
                detailImageView.frame = selectedCellFrame
            } else {
                toView.alpha = oneAlpha
                guard let detailImageView = detailImageView else { return }
                strongSelf.cell?.frame = detailImageView.frame
            }
        }) { [weak self] (isFinished) in
            if transitionContext.transitionWasCancelled {
                toView.removeFromSuperview()
            } else {
                fromView.removeFromSuperview()
            }
            
            self?.cell?.removeFromSuperview()
            detailImageView.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
