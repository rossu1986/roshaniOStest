//
//  ServerHandler.swift
//  DemoTest
//
//  Created by Roshan on 7/31/18.
//  Copyright © 2018 Roshan Mishra. All rights reserved.
//

import UIKit
import SystemConfiguration

class ServerHandler: NSObject {
    
    /// Network Activity
    class func isNetWorkAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
        
    }
    
    class func sendGetRequest(functionName : String, showLoader: Bool,  completionHandler:@escaping ((_ responseValue: Any?, _ error: Error?) -> Void)) -> Void {
        /// Check Network Availability
        
        if isNetWorkAvailable() == true {
            // Show Activity
            if showLoader {
                DispatchQueue.main.async(execute: {
                    ActivityIndicatorView.showActivity()
                })
            }
            let aboutCountryUrl = APIPaths.baseUrl + functionName
           
            // Set up the URL request
            guard let url = URL(string: aboutCountryUrl) else {
                print("Error: cannot create URL")
                return
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            urlRequest.httpMethod = "GET"

            // set up the session
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            /// make the request
            let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                
                /// Hide Activity
                if showLoader {
                    DispatchQueue.main.async(execute: {
                        ActivityIndicatorView.hideActivity()
                    })
                }
                
                /*
                  Check the server data and error if we get error result equal to nil
                  then we immediate return the function
                */
                guard let data = data, error == nil else {
                    return
                }
                let httpStatus = response as? HTTPURLResponse
                
                /*
                 Check server response status code
                 
                 - Success: If we get status code equal to 200 it means we get success response
                 and return success result to the function.
                 - Failure: If we get status code not equal to 200 then return the error message  to the function
 
                */
                if httpStatus?.statusCode == 200 {
                    /// Convert first data to UTF8 encoding
                    let utfStringData = String(data: data, encoding: .isoLatin1)
                    completionHandler(utfStringData, nil)
                } else {
                    completionHandler(nil, error)
                }
                
            })
            task.resume()
            
            
        } else {
            AlertView.showAlert(title: Messages.Network.title, message: Messages.Network.message, cancelBtnTitle: "OK")
        }
    }
    
}
