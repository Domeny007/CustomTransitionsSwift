//
//  DetailViewController.swift
//  CustomTransitionsSwift
//
//  Created by Азат Алекбаев on 22.04.2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet var backgroundView: UIView!
    var image: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImageView.image = image
        navigationItem.title = "Image"
    }
}
