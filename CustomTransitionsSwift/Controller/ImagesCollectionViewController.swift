//
//  ImagesCollectionViewController.swift
//  CustomTransitionsSwift
//
//  Created by Азат Алекбаев on 22.04.2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

import UIKit

class ImagesCollectionViewController: UICollectionViewController {
    
    let customZoomTransition = CustomZoomTransition()
    let swipeImageRecognizer = SwipeImageRecognizer()
    var images = Images.generateImages(numberOfItems: 20)
    let selectedCellPosition: CGPoint! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        guard let collectionViewWidth = collectionView?.frame.width else {return}
        let itemWidth = (collectionViewWidth - HelpingConstants.leftAndRightPaddings) / HelpingConstants.numberOfItemsPerRow
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
            layout.minimumLineSpacing = 1
            layout.minimumInteritemSpacing = 1
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView?.reloadData()
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HelpingConstants.imageCollectionViewCell, for: indexPath) as! ImageCollectionViewCell
        let imageNames = images[indexPath.item]
        cell.imageName = imageNames
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = UIImage(named: images[indexPath.item])
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            customZoomTransition.cell = cell
            customZoomTransition.selectedCellFrame = collectionView.convert(cell.frame, to: self.view)
        }
        performSegue(withIdentifier: HelpingConstants.showDetailSegue, sender: image)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == HelpingConstants.showDetailSegue {
            guard let image = sender as? UIImage else { return }
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.image = image
        }
    }
    
}

extension ImagesCollectionViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            if let detailViewController = toVC as? DetailViewController {
                swipeImageRecognizer.attach(to: detailViewController)
            }
        }
        customZoomTransition.beganPresenting = operation == .pop
        return customZoomTransition
        
    }
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return swipeImageRecognizer.startedPresentingTransition ? swipeImageRecognizer : nil
    }
}
