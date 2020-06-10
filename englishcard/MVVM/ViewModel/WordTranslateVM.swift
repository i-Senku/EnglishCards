//
//  WordTranslateVM.swift
//  englishcard
//
//  Created by Ercan on 14.05.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import Foundation

class WordTranslateVM {
    var translateList : [Translate] = [Translate]()
    
    func fetchTranslateWord(completionHandler: @escaping ()->()){
        if let language = UserDefaults.standard.object(forKey: "mainlanguage") as? String {
            let loverLanguage = language.lowercased()
            fetchTranslate(language: loverLanguage) { [weak self] translateWord in
                self!.translateList = translateWord
                completionHandler()
            }
        }
    }
}
