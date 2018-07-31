//
//  AboutCountryViewModel.swift
//  DemoTest
//
//  Created by Roshan on 7/31/18.
//  Copyright © 2018 Roshan Mishra. All rights reserved.
//

import Foundation
import UIKit

class AboutCountryViewModel {
    var aboutCountryDatas = [AboutCountry]()
    var aboutCountryName: String!
    
    // MARK:- Get About Country Data From Server
    func getAboutCountryData(completionBlock : @escaping (() ->())) {
        let aboutCountryUrl = APIPaths.itemsUrl
        
        ServerHandler.sendGetRequest(functionName: aboutCountryUrl, showLoader: true) { (result, error) in
            //Success result from the server
            if error == nil {
                let response = self.convertToDictionary(text: result as! String)
                self.aboutCountryName = response!["title"] as! String
                if let responseData = response!["rows"], responseData is [[String: Any]]{
                    let responseDictionary = responseData as! [[String : Any]]
                    for countryDetail in responseDictionary{
                        let aboutCountry = AboutCountry(data: countryDetail)
                        self.aboutCountryDatas.append(aboutCountry)
                    }
                }
            } else {
                AlertView.showAlert(title: "Alert!", message: "Can't load items", cancelBtnTitle: "OK")
            }
            completionBlock()
            
        }
    }
    
    //MARK: Convert String to Dictionary
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    //MARK: Return number of rows
    func numberOfRows() -> Int {
        return aboutCountryDatas.count
    }
    
    //MARK: Return About Country data for showing on cell
    func getCountryRecord(indexPath : IndexPath) -> AboutCountry {
        return aboutCountryDatas[indexPath.row]
    }
    
}



