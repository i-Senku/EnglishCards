//
//  HomePageVM.swift
//  englishcard
//
//  Created by Ercan on 12.05.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import Foundation
import UIKit

class HomePageVM {
    var categories : [Category] = [Category]()
        
    func getCategory(completionHandler : @escaping ()->()) -> Void {
        fetchData { [weak self] list in
            self!.categories = list
            completionHandler()
        }
    }
    
}
