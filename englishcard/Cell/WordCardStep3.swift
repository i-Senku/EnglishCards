//
//  WordCardStep3.swift
//  englishcard
//
//  Created by Ercan on 22.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit

protocol CheckCelebrationDelegate : AnyObject {
    func checkCelebration(word:String)
}

class WordCardStep3: UICollectionViewCell {
    
    @IBOutlet weak var wordText: UITextField!
    @IBOutlet weak var wordName: UILabel!
    @IBOutlet weak var checkButton: UIButton!
        
    weak var delegate : CheckCelebrationDelegate?
    
    override func awakeFromNib() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: wordText.bounds.maxY-10, width: wordText.frame.width, height: 2)
        bottomLine.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        wordText.borderStyle = .none
        
        wordText.layer.addSublayer(bottomLine)
    }
    @IBAction func checkText(_ sender: Any) {
        delegate?.checkCelebration(word: wordText.text!.lowercased())
    }
    
}
