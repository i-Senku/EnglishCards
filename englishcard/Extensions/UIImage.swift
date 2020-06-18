//
//  UIImage.swift
//  englishcard
//
//  Created by Ercan on 12.05.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit

extension UIImage {

    public static func loadFrom(url: String,completion: (UIImage?)->Void){
        
        guard let imageURL = URL(string: url) else {return}
        let data = try! Data(contentsOf: imageURL)
        
        if let image = UIImage(data: data) {
            completion(image)
        }
        
    }

}
