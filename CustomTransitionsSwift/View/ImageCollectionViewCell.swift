//
//  ImageCollectionViewCell.swift
//  CustomTransitionsSwift
//
//  Created by Азат Алекбаев on 22.04.2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageImageView: UIImageView!
    
    var imageName: String? {
        didSet{
            guard let imageName = imageName else { return }
        imageImageView.image = UIImage(named: imageName)
        }
    }
}
