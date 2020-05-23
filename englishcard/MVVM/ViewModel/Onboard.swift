//
//  Onboard.swift
//  englishcard
//
//  Created by Ercan on 4.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import Foundation
import paper_onboarding

struct OnboardViewModel {
    
    static let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
    static let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
    
    let items = [
        OnboardingItemInfo(informationImage: UIImage(named: "Hotels")!,
                           title: "Search",
                           description: "All hotels and hostels are sorted by hospitality rating",
                           pageIcon: UIImage(named: "Hotels")!,
                           color: UIColor(red: 0.40, green: 0.56, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: UIImage(named: "Key")!,
                           title: "Offline Mode",
                           description: "We carefully verify all banks before add them into the app",
                           pageIcon: UIImage(named: "Key")!,
                           color: UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: UIImage(named: "Hotels")!,
                           title: "Premium",
                           description: "All local stores are categorized for your convenience",
                           pageIcon: UIImage(named: "Hotels")!,
                           color: UIColor(red: 0.61, green: 0.56, blue: 0.74, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white,
                           titleFont: titleFont, descriptionFont: descriptionFont),
        
        ]
}
