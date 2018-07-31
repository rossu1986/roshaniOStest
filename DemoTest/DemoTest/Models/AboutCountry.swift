//
//  AboutCountry.swift
//  DemoTest
//
//  Created by Roshan on 7/31/18.
//  Copyright © 2018 Roshan Mishra. All rights reserved.
//

import UIKit

class AboutCountry: NSObject {
    var title: String
    var des: String
    var imageUrl: String
    
    init(data:[String : Any]) {
        title = data["title"] as? String ?? ""
        des = data["description"] as? String ?? ""
        imageUrl = data["imageHref"] as? String ?? ""
    }
    
}
