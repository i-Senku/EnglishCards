//
//  WordCardStep2.swift
//  englishcard
//
//  Created by Ercan on 22.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit
import AVFoundation

protocol QuizDelegate {
    func checkQuestion(status : Bool)
}


class WordCardStep2: UICollectionViewCell {
    
    @IBOutlet weak var wordName: UILabel!
    @IBOutlet weak var speaker: UIImageView!
    
    @IBOutlet var btnCollections: [UIButton]!
    var quizDelegate : QuizDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        speakerGesture()
    }
    
    func speakerGesture(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(speak))
        speaker.addGestureRecognizer(gesture)
        speaker.isUserInteractionEnabled = true
    }
    
    @objc func speak(){
        readText(content: wordName.text!)
        
    }
    
    @IBAction func actionButton(_ sender: Any) {
        if let btn = sender as? UIButton {
            print(btn.tag)
            if btn.tag != 0{
                
                btn.backgroundColor = #colorLiteral(red: 0.2975081275, green: 0.7736357384, blue: 1, alpha: 1)
                btn.pulse()
                btnCollections.forEach { (item) in
                    if item.tag != btn.tag {
                        item.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
                        item.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
                    }
                }
                quizDelegate?.checkQuestion(status: true)
            }else{
                btn.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                btn.shake()
                btnCollections.forEach { (item) in
                    item.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
                }
            }
            quizDelegate?.checkQuestion(status: false)
        }
        
    }
    
}
