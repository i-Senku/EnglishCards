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
    func showAlert()
}

protocol FavoriteItemDelegate {
    func addItem()
    func deleteItem()
}

class WordCard: UICollectionViewCell {
    
    @IBOutlet weak var wordName: UILabel!
    @IBOutlet weak var wordImageLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var heartImage: UIImageView!
    
    var heartAnimation : AnimatedButton = {
        let animation = Animation.named("TwitterHeartButton")!
        let view = AnimatedButton(animation: animation)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    
    var delegate : AlertShower?
    var itemDelegate : FavoriteItemDelegate?
    var isShow = false
    var isItemSelect = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageRecognizer()
        //setupAnimation()
    }
    
    func imageRecognizer() -> () {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(liked))
        heartImage.addGestureRecognizer(gesture)
        heartImage.isUserInteractionEnabled = true
    }

    @objc func liked(){
        isItemSelect = !isItemSelect
        if isItemSelect {
            heartImage.image = UIImage(systemName: "heart.fill")
            itemDelegate?.addItem()
            delegate?.showAlert()
        }else{
            heartImage.image = UIImage(systemName: "heart")
            itemDelegate?.deleteItem()
        }
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

