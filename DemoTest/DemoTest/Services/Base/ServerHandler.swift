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
    
    // Network Activity
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
        // Check Network Availability
        if isNetWorkAvailable() == true {
            // Show Activity
            if showLoader {
                DispatchQueue.main.async(execute: {
                    ActivityIndicatorView.showActivity()
                })
            }
            let url = APIPaths.baseUrl + functionName
            //print("Request Url: \(url)")
            
            
            
        } else {
            AlertView.showAlert(title: Messages.Network.title, message: Messages.Network.message, cancelBtnTitle: "OK")
        }
    }
    
}
