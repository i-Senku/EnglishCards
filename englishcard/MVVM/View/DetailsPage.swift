//
//  DetailsPage.swift
//  englishcard
//
//  Created by Ercan on 12.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class DetailsPage: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var detailsImage : UIImage?
    let detailsVM = DetailsPageVM()
    var id : Int?
    var levelCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detailsVM.getCategory(id: id) {
            self.collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! WordsPage
        if let level = sender as? Int {
            let wordsOfLevel = detailsVM.words.filter { (words) -> Bool in
                words.level == level
            }
            vc.wordList = wordsOfLevel
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.tabBarController?.tabBar.isHidden = true
        }
    }

}
extension DetailsPage : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return levelCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "details", for: indexPath) as! Details
        cell.detailsImage.image = detailsImage
        cell.levelText.text = "Level \(indexPath.row+1)"
        return cell
    }
    
    fileprivate func configurationLayout(){
        let layout = UPCarouselFlowLayout()
        let width = collectionView.bounds.size.width
        let height = collectionView.bounds.size.height
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width/1.35, height: height-50)
        collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "wordcard", sender: indexPath.row+1)
    }
    
}
