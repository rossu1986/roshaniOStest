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
    
    /// Get the About Country data from server using REST API.
    ///
    /// - Parameter completionBlock: completion block to notify get the response from REST API
    func getAboutCountryData(completionBlock : @escaping (() ->())) {
        let aboutCountryUrl = APIPaths.itemsUrl
        
        ServerHandler.sendGetRequest(functionName: aboutCountryUrl, showLoader: true) { [weak self](result, error) in
            //Success result from the server
            if error == nil {
                /// Remove old data from array
                self?.aboutCountryDatas.removeAll()
                let response = self?.convertToDictionary(text: result as! String)
                
                /// store about country title for showing Navigation Bar
                self?.aboutCountryName = response!["title"] as! String
                if let responseData = response!["rows"], responseData is [[String: Any]]{
                    let responseDictionary = responseData as! [[String : Any]]
                    for countryDetail in responseDictionary{
                        let aboutCountry = AboutCountry(data: countryDetail)
                        self?.aboutCountryDatas.append(aboutCountry)
                    }
                }
            } else {
                /// In case if server send the error then show the message
                AlertView.showAlert(title: "Alert!", message: "Can't load items", cancelBtnTitle: "OK")
            }
            completionBlock()
            
        }
    }
    
    // MARK: Convert String to Dictionary
    
    /// Convert String to Dictionary with jsonObject method of JSONSerialization
    ///
    /// - Parameter text: pass the valid string
    /// - Returns: Optional Dictionary of type [String: Any]?
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
    
    /// Get the count of the country to show country list
    ///
    /// - Returns: total number of country count
    func numberOfRows() -> Int {
        return aboutCountryDatas.count 
    }
    
    //MARK: Return About Country data for showing on cell
    
    /// Get the country corresponding to passed index path
    ///
    /// - Parameter indexPath: pass the valid/selected index path
    /// - Returns: AboutCountry object
    func getCountryRecord(indexPath : IndexPath) -> AboutCountry {
        return aboutCountryDatas[indexPath.row]
    }
    
}



