//
//  UIView.swift
//  englishcard
//
//  Created by Ercan on 10.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit

extension UIView{
    
    func roundedView(corners : UIRectCorner , radius : Int){
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        
        self.layer.mask = maskLayer
    }
    
    func setGradientLayer(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = [#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor,#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor,]
        gradientLayer.shouldRasterize = true
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}



