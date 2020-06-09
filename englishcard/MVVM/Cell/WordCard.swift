//
//  WordCard.swift
//  englishcard
//
//  Created by Ercan on 18.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit
import Lottie
import FirebaseAuth

protocol AlertShower : AnyObject{
    func showAlert(title:String, message:String)->()
}

protocol FavoriteItemDelegate: AnyObject{
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
    
    let firebaseAuth = Auth.auth()
    weak var delegate : AlertShower?
    weak var itemDelegate : FavoriteItemDelegate?
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
        if firebaseAuth.currentUser != nil{
            
            if !isItemSelect {
                heartImage.image = UIImage(systemName: "heart.fill")
                itemDelegate?.addItem()
                delegate?.showAlert(title: "Added", message: "This word added your favorites box")
            }else{
                heartImage.image = UIImage(systemName: "heart")
                itemDelegate?.deleteItem()
                delegate?.showAlert(title: "Deleted", message: "This word deleted from your favorites box")
            }
            
            print(isSelected)
            isItemSelect = !isItemSelect
            NotificationCenter.default.post(name: .updateCoreData, object: nil)
            
        }else{
            delegate?.showAlert(title: "Login Failed", message: "Please Register")
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

