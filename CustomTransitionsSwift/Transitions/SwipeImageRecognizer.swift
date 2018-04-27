//
//  SwipeImageRecognizer.swift
//  CustomTransitionsSwift
//
//  Created by Азат Алекбаев on 26.04.2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

import UIKit

class SwipeImageRecognizer: UIPercentDrivenInteractiveTransition {
    
    var navigationController: UINavigationController!
    var viewController: DetailViewController!
    var gestureShouldComplete: Bool = false
    var startedPresentingTransition: Bool = false
    var viewTransitionComplete: CGFloat = 0
    var animationDuration = 0.5
    let viewsMainHeight: CGFloat = 100
    func attach(to detailViewController: DetailViewController) {
        viewController = detailViewController
        navigationController = detailViewController.navigationController
        setupGestureRecognizer(view: detailViewController.view)
    }
    
    private func setupGestureRecognizer(view: UIView) {
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gestureRecognizer:))))
    }
    @objc func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        guard let superView = gestureRecognizer.view?.superview   else { return }
        let viewTransition = gestureRecognizer.translation(in: superView)
        
        guard let detailImageView = viewController.detailImageView else { return }
        detailImageView.center = CGPoint(x: detailImageView.center.x, y: detailImageView.center.y + viewTransition.y)
        UIView.animate(withDuration: animationDuration) { [weak self] in
            guard let strongSelf = self else { return }
            let backgroundAlpha = 1 - (abs(superView.center.y - detailImageView.center.y) / 475)
            strongSelf.viewController.backgroundView.alpha = backgroundAlpha
            
        }
        
        
        if gestureRecognizer.state == .began {
            startedPresentingTransition = true
            navigationController.popViewController(animated: true)
            
        } else if gestureRecognizer.state == .changed {
            viewTransitionComplete += viewTransition.y
            let const = viewTransitionComplete / viewsMainHeight
            gestureShouldComplete = const > 0.5
        } else if gestureRecognizer.state == .cancelled || gestureRecognizer.state == .ended || gestureRecognizer.state == .failed {
            startedPresentingTransition = false
            viewTransitionComplete = 0
            if !gestureShouldComplete || gestureRecognizer.state == .cancelled {
                cancel()
            } else {
                finish()
                UIView.animate(withDuration: animationDuration) { [weak self] in
                    self?.viewController.backgroundView.alpha = 0
                    
                }
            }
        }
        gestureRecognizer.setTranslation(CGPoint.zero, in: superView)
    }
    
}



