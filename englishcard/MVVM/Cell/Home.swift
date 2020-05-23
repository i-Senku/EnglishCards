//
//  Home.swift
//  englishcard
//
//  Created by Ercan on 10.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit

class Home: UICollectionViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.borderWidth = 0.3
    }
}
