//
//  HomePage.swift
//  englishcard
//
//  Created by Ercan on 7.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit
import Kingfisher
import Lottie

final class HomePage: UIViewController {
    
    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var cardList: UICollectionView!
    
    var homeVM : HomePageVM = HomePageVM()
    var imageList : [UIImage?] = [UIImage?]()
    var id = 0
    
    let animationView : AnimationView = {
        let view = AnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let animation = Animation.named("progress")
        view.animation = animation
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutAnimationView()
        fetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let image = sender as? UIImage {
            let vc = segue.destination as! DetailsPage
            vc.detailsImage = image
            vc.id = id
        }
    }
    
    fileprivate func layoutAnimationView(){
        view.addSubview(animationView)
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        animationView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        animationView.play()
        animationView.loopMode = .loop
    }
    
}

extension HomePage : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeVM.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "home", for: indexPath) as! Home
        
        let list = homeVM.categories[indexPath.row]
        
        cell.nameText.text = list.categoryName
        cell.imageView.image = imageList[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = Int((collectionView.bounds.size.width - 30) / 2)
        return CGSize(width: width, height: width)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = collectionView.cellForItem(at: indexPath) as! Home
        let image = currentCell.imageView.image
        id = homeVM.categories[indexPath.row].id
        performSegue(withIdentifier: "details", sender: image)
        
    }
}

extension HomePage{
    
    func fetchData(){
        let myQue = DispatchQueue(label: "myque")
        myQue.async {
                self.homeVM.getCategory(completionHandler: {
                    myQue.async {
                        for i in self.homeVM.categories{
                            UIImage.loadFrom(url: i.categoryImage) { (image) in
                                self.imageList.append(image)
                            }
                        }
                        DispatchQueue.main.async {
                            self.animationView.stop()
                            self.animationView.isHidden = true
                            self.cardList.reloadData()
                        }
                    }
        
                })
                
            
        }
    }    
    
}
