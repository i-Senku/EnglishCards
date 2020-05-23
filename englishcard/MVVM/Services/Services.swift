//
//  Services.swift
//  englishcard
//
//  Created by Ercan on 11.05.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import Alamofire

func fetchData(completionHandler: @escaping ([Category]) -> () ){
    let url = "http://localhost:8080/category";
    AF.request(url).responseJSON { (jsonData) in
        
        guard let data = jsonData.data else {return}
        
        do{
            let json = try JSONDecoder().decode([Category].self, from: data)
            completionHandler(json)
        }catch{
            print(error)
        }
        
    }
}

func fetchWords(id: Int?,completionHandler: @escaping ([Words])->Void ){
    guard let myID = id else {return}
    let url = "http://localhost:8080/words/\(myID)";
    
    AF.request(url).responseJSON { (jsonData) in
        guard let data = jsonData.data else {return}

        do{
            let json = try JSONDecoder().decode([Words].self, from: data)
            completionHandler(json)
        }catch{
            
        }
    }
}

func fetchTranslate(language:String,completionHandler : @escaping ([Translate]) -> ()){
    let url = "http://localhost:8080/\(language)";
    
    AF.request(url).responseJSON { (jsonData) in
        guard let data = jsonData.data else {return}
        
        do{
            let json = try JSONDecoder().decode([Translate].self, from: data)
            completionHandler(json)
        }catch{
            
        }
    }
}
