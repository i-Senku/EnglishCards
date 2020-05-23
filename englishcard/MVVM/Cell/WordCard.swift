//
//  WordCard.swift
//  englishcard
//
//  Created by Ercan on 18.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit
import Lottie

protocol AlertShower{
    func showAlert(cell: WordCard)
}

class WordCard: UICollectionViewCell {
    
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var wordName: UILabel!
    @IBOutlet weak var wordImageLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    let heartAnimation : AnimatedButton = {
        let animation = Animation.named("TwitterHeartButton")!
        let view = AnimatedButton(animation: animation)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.setPlayRange(fromMarker: "touchDownStart", toMarker: "touchDownEnd", event: .touchDown)
        view.setPlayRange(fromMarker: "touchDownEnd", toMarker: "touchUpCancel", event: .touchUpOutside)
        view.setPlayRange(fromMarker: "touchDownEnd", toMarker: "touchUpEnd", event: .touchUpInside)
        return view
    }()
    
    
    var delegate : AlertShower?
    var isShow = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAnimation()
        
    }
    
    func imageRecognizer() -> () {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(liked))
        likeImage.addGestureRecognizer(gesture)
        likeImage.isUserInteractionEnabled = true
    }

    @objc func liked(){
        delegate?.showAlert(cell: self)
    }
    
    private func setupAnimation(){
        mainView.addSubview(heartAnimation)
        NSLayoutConstraint.activate([
            heartAnimation.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,constant: -20),
            heartAnimation.topAnchor.constraint(equalTo: mainView.topAnchor,constant: 20),
            heartAnimation.heightAnchor.constraint(equalToConstant: 50),
            heartAnimation.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        
    }
    
}

