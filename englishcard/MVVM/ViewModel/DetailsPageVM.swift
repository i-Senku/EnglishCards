//
//  DetailsPageVM.swift
//  englishcard
//
//  Created by Ercan on 13.05.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import Foundation

class DetailsPageVM {
    var words : [Words] = [Words]()
        
    func getCategory(id:Int?,completionHandler : @escaping ()->()) -> Void {
        fetchWords(id: id) { [weak self] words in
            self!.words = words
            completionHandler()
        }
    }
    
}

