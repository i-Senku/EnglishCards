//
//  Words.swift
//  englishcard
//
//  Created by Ercan on 13.05.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import Foundation

struct Words : Decodable{
    
    let id : Int
    let word : String
    let turkishID : Int
    let spanishID : Int
    let germanID : Int
    let categoryID : Int
    let level : Int
}
