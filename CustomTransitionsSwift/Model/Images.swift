//
//  Images.swift
//  CustomTransitionsSwift
//
//  Created by Азат Алекбаев on 22.04.2018.
//  Copyright © 2018 Азат Алекбаев. All rights reserved.
//

import Foundation
import UIKit
class Images {
    static func generateImages(numberOfItems: Int) -> [String] {
        var imageNames = [String]()
        for i in 1..<numberOfItems {
            imageNames.append("\(i)")
        }
        return imageNames
    }
    
}
