//
//  MemberShipPage.swift
//  englishcard
//
//  Created by Ercan on 27.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class MemberShipPage: UIViewController {

    let productList = ["1 Week","1 Year","1 Month"]

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationLayout()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let indexPath = IndexPath(row: 1, section: 0)

        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

}

extension MemberShipPage : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "membership", for: indexPath) as! MemberShip
        cell.title.text = productList[indexPath.row]
        return cell
    }
    
    fileprivate func configurationLayout(){
        let layout = UPCarouselFlowLayout()
        let width = collectionView.bounds.size.width
        let height = collectionView.bounds.size.height
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width/1.35, height: height-100)
        self.collectionView.collectionViewLayout = layout
    }
    
}

extension MemberShipPage : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath) as! MemberShipProduct
        return cell
    }
    
    
}
