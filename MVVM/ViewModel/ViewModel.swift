//
//  ViewModel.swift
//  MVVM
//
//  Created by Darshan on 08/03/22.
//

import UIKit
import Combine

public class ViewModel: NSObject {

     override init() {
        super.init()
    }
    func fetchWatchListData()-> Future<[WatchList]?,Error>{
        return Future { promise in
            
            if let url = Bundle.main.url(forResource: "watchlist1_data", withExtension: "json") {
                    do {
                        let data = try Data(contentsOf: url)
                        let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        if let dictionary = object as? [String: AnyObject] {
                            if let arrayofData = dictionary["Data"] as? [[String:Any]]{
                                let dataObject = try JSONSerialization.data(withJSONObject: arrayofData, options: .prettyPrinted)
                                let decoder = JSONDecoder()
                                let jsonData = try decoder.decode([WatchList].self, from: dataObject)
                                promise(.success(jsonData))
                                print(jsonData)
                            }
                        }
                    } catch {
                        print("error:\(error)")
                    }
                }
        }
    }
}
extension UIStoryboard{
    class var mainStoryBoard:UIStoryboard{
        return UIStoryboard.init(name: "Main", bundle: nil)
    }
}
