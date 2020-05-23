//
//  TextField.swift
//  englishcard
//
//  Created by Ercan on 6.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setIcon(image : UIImage){
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        
        let iconContainer = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainer.addSubview(iconView)
        
        leftView = iconContainer
        leftViewMode = .always
    }
}
