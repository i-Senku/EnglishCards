//
//  WordsPage.swift
//  englishcard
//
//  Created by Ercan on 13.04.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class WordsPage: UIViewController{

    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    let wordTranslateVM = WordTranslateVM()
    var wordList = [Words]()
    var favoriteList = [Favorites]()
    var myPath : IndexPath?
    var avPlayer : AVAudioPlayer?
    var progressCount : Float = 0.0
    
    let context = appDelegate.persistentContainer.viewContext
    

    
    // MARK: Create Touch Image
    let touchImage : UIImageView = {
        let screenSize = UIScreen.main.bounds.size
        let view = UIImageView(frame: CGRect(origin: CGPoint(x: screenSize.width * 0.4, y: screenSize.height * 0.6), size: CGSize(width: 100, height: 100)))
        view.image = UIImage(named: "touch")
        view.alpha = 0
        return view
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFavoriteListFromCoreData()
        
        wordTranslateVM.fetchTranslateWord {
            var tempList : [Translate] = [Translate]()
            self.wordTranslateVM.translateList.forEach { (item) in
                self.wordList.forEach { (words) in
                    if item.id == words.turkishID {
                        tempList.append(item)
                    }
                }
            }
            self.wordTranslateVM.translateList = tempList
            self.collectionView.reloadData()
        }
        
        progressView.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        view.addSubview(touchImage)
        touchAnimation()
    }
    
    // MARK: Animation Settings for Touch Image
    private func touchAnimation(){
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat], animations: {
            self.touchImage.alpha = 1
            self.touchImage.bounds.size.width = 50
            self.touchImage.bounds.size.height = 50
        }, completion: nil)
    }
    
    func setProgressView(){
        UIView.animate(withDuration: 0.5) {
            let sayi : Float = Float(1.0 / Float(self.wordList.count*3))
            self.progressCount += sayi
            print("Progress : \(self.progressCount)")
            self.progressView.setProgress(self.progressCount, animated: true)
        }
    }
    
    func fetchFavoriteListFromCoreData(){
        let fetchRequest:NSFetchRequest<Favorites> = Favorites.fetchRequest()
        
        do {
            favoriteList = try context.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    fileprivate func playSound(sounds : Sounds){
        let path = Bundle.main.path(forResource: sounds.rawValue, ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        
        do {
           avPlayer =  try AVAudioPlayer(contentsOf: url)
            print("Çaldı")
            avPlayer?.play()
        } catch {
            print("Error Sound")
        }
    }
    
    
}

// MARK: CollectionViews Configrations

extension WordsPage : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordList.count
    }
    
    // MARK: Configration of Cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! WordCard
        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! WordCardStep2
        let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! WordCardStep3
        
        // MARK: First Card Section = 0
        if indexPath.section == 0 {
            cell1.delegate = self
            cell1.itemDelegate = self
            cell1.wordName.text = wordList[indexPath.row].word
            cell1.wordImageLabel.text = "🙈"
            cell1.heartImage.image = UIImage(systemName: "heart")
            
            favoriteList.forEach { (item) in
                if item.id == wordList[indexPath.row].id {
                    cell1.isItemSelect = true
                    cell1.heartImage.image = UIImage(systemName: "heart.fill")
                }else{
                    cell1.heartImage.image = UIImage(systemName: "heart")
                    cell1.isItemSelect = false
                }
            }
            
        }// MARK: Second Card Section = 1
        else if indexPath.section == 1 {
            
            let id = wordList[indexPath.row].turkishID
            let trueWord = wordTranslateVM.translateList.first { (item) -> Bool in
                item.id == id
            }
            var tempList = wordTranslateVM.translateList
            if var tempButton = cell2.btnCollections{
                
                let randNumber = Int.random(in: 0...tempButton.count-1)
                
                let randomBtn = tempButton.remove(at: randNumber)
                randomBtn.setTitle(trueWord?.wordName, for: .normal)
                randomBtn.tag = trueWord!.id
                randomBtn.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)

                tempList.removeAll { (item) -> Bool in
                    item.id == trueWord?.id
                }
                
                tempButton.forEach { (button) in
                    let randNumberList = Int.random(in: 0...tempList.count-1)
                    let randomItem = tempList.remove(at: randNumberList)
                    button.setTitle(randomItem.wordName, for: .normal)
                    button.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
                    button.tag = 0
                }
            }
            cell2.wordName.text = wordList[indexPath.row].word
            cell2.quizDelegate = self
            
        }else{
            // MARK: Last Card Section = 2
            cell3.wordName.text = wordTranslateVM.translateList[indexPath.row].wordName
            cell3.wordText.text = ""
            cell3.checkButton.setTitle("Check", for: .normal)
            cell3.delegate = self
            
        }
        let liste = [cell1,cell2,cell3]
        return liste[indexPath.section]
    }
    
    
    // MARK: CollectionView Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    // MARK: Last IndexPath Found
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in collectionView.visibleCells{
            if let row = collectionView.indexPath(for: cell){
                myPath = row
                if myPath?.section != 0{
                    collectionView.isScrollEnabled = false
                }
                setProgressView()
            }
        }
    }
    
    // MARK: Select and Show Card
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if let cell = collectionView.cellForItem(at: indexPath) as? WordCard {
                if cell.isShow {
                    UIView.transition(with: cell.contentView, duration: 0.4, options: .transitionFlipFromLeft, animations: {
                        cell.wordName.text = self.wordList[indexPath.row].word
                    }, completion: {_ in
                    })
                    cell.wordImageLabel.text = "🙈"
                    cell.isShow = !cell.isShow
                    
                }else{
                    
                    UIView.transition(with: cell.contentView, duration: 0.4, options: .transitionFlipFromRight, animations: {
                        let id = self.wordList[indexPath.row].turkishID
                        self.wordTranslateVM.translateList.forEach { (item) in
                            if id == item.id {
                                cell.wordName.text = item.wordName
                            }
                            cell.wordImageLabel.text = "🙉"
                            cell.isShow = !cell.isShow
                        }
                    }, completion: {_ in
                        if let index = collectionView.indexPathsForVisibleItems.first{
                                readText(content: self.wordList[index.row].word)

                            }
                    })
                }
                touchImage.alpha = 0
            }

        }
    }
}

// MARK: Alert and Celebration Delegate Functions
extension WordsPage : AlertShower,QuizDelegate,CheckCelebrationDelegate,FavoriteItemDelegate{
    
    func addItem() {
        
        if let path = collectionView.indexPathsForVisibleItems.first {
            let favorites = Favorites(context: context)
            
            favorites.id = Int32(self.wordList[path.row].id)
            favorites.wordName = self.wordList[path.row].word
            self.wordTranslateVM.translateList.forEach { (item) in
                if self.wordList[path.row].id == item.id {
                    favorites.wordTranslate = item.wordName
                }
            }
            
            do {
                try context.save()
                print("Kayıt Edildi")
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func deleteItem() {
        let fetchRequest:NSFetchRequest<Favorites> = Favorites.fetchRequest()
        
        do {
            let list =  try context.fetch(fetchRequest)
            
            if let path = collectionView.indexPathsForVisibleItems.first {
                var deletedItem : Favorites?
                list.forEach { (item) in
                    if self.wordList[path.row].id == item.id {
                        deletedItem = item
                        context.delete(item)
                    }
                }
                if let _ = deletedItem {
                    try context.save()
                }
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    func checkCelebration(word: String) {
        self.view.endEditing(true)
        
        if let path = collectionView.indexPathsForVisibleItems.first{
            
            if word.count > 0 {
                let cell = collectionView.cellForItem(at: path) as! WordCardStep3
                
                if word == wordList[path.row].word.lowercased() {
                    cell.checkButton.pulse()
                    print(word)
                    print(wordList.last!.word)
                    if word == wordList.last!.word.lowercased(){
                        self.playSound(sounds: .trueSound)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            self.setProgressView()
                            self.performSegue(withIdentifier: "celebration", sender: nil)
                        }
                        
                    }else{
                        let nextPath = IndexPath(row: path.row+1, section: path.section)
                        self.playSound(sounds: .trueSound)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            self.setProgressView()
                            self.collectionView.scrollToItem(at: nextPath, at: .centeredHorizontally, animated: true)
                        }
                    }

                }else{
                    cell.checkButton.shake()
                    self.playSound(sounds: .falseSound)
                }
                
            }else{
                let alert = UIAlertController(title: "EMPTY", message: "This textfield cannot be empty", preferredStyle: .alert)
                
                let actionOkey = UIAlertAction(title: "OK", style: .default) { (_) in
                }
                alert.addAction(actionOkey)
                
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    func checkQuestion(status: Bool) {
        if status{
            if let path = collectionView.indexPathsForVisibleItems.first{
                
                if path.row == wordList.count-1 {
                    let nextPath = IndexPath(row: 0, section: path.section+1)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.setProgressView()
                        self.collectionView.scrollToItem(at: nextPath, at: .centeredHorizontally, animated: true)
                    }
                }else{
                    let nextPath = IndexPath(row: path.row+1, section: path.section)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.collectionView.scrollToItem(at: nextPath, at: .centeredHorizontally, animated: true)
                        self.setProgressView()
                        
                    }
                }
                
            }
        }
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let actionOkey = UIAlertAction(title: "Okay", style: .default) { (_) in
        }
        alert.addAction(actionOkey)
        
        present(alert, animated: true, completion: nil)
    }
}
