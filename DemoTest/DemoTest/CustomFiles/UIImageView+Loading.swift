//
//  UIImageView+Loading.swift
//  DemoTest
//
//  Created by Roshan on 7/31/18.
//  Copyright © 2018 Roshan Mishra. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView {
    
    func loadImage(_ url: String) {
        guard url.isEmpty == false else {
            return
        }
        
        if let uRL = URL(string: url) {
            self.sd_setImage(with: uRL, placeholderImage: nil, options: SDWebImageOptions.cacheMemoryOnly) { (image, error, cacheType, url) in
                
                if let error = error {
                    print("Image Loading error : \(error)")
                }
            }
            
        }
    }
}
