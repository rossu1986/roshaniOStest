//
//  AboutCountryCollectionViewCell.swift
//  DemoTest
//
//  Created by Roshan on 7/31/18.
//  Copyright © 2018 Roshan Mishra. All rights reserved.
//

import UIKit

class AboutCountryCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    
    static var reusableIdentifer = "cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
        
        addConstraints()
    }
    
    private func commonInit() {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        self.contentView.addSubview(imageView)
        self.imageView = imageView
        
        let titleLabel = UILabel(frame: .zero)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        titleLabel.font = UIFont.systemFont(ofSize: 13.0)
        self.contentView.addSubview(titleLabel)
        self.titleLabel = titleLabel
        
        let descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 4
        descriptionLabel.sizeToFit()
        descriptionLabel.font = UIFont.systemFont(ofSize: 11.0)
        self.contentView.addSubview(descriptionLabel)
        self.descriptionLabel = descriptionLabel
        
    }
    
    /// Add layout Constraints programmatically to all the subviews
    fileprivate func addConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                
                imageView.leftAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leftAnchor, constant: 10),
                imageView.centerYAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.centerYAnchor)
                ])
        } else {
            // Fallback on earlier versions
            NSLayoutConstraint.activate([
                imageView.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor, constant: 10),
                imageView.centerYAnchor.constraint(equalTo: self.layoutMarginsGuide.centerYAnchor)
                ])
        }
        
        self.contentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: imageView, attribute: .height, multiplier: 1.0, constant: 0.0))
        
        
        NSLayoutConstraint.activate([
            
            NSLayoutConstraint(item: titleLabel,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: imageView,
                               attribute: .trailing,
                               multiplier: 1.0,
                               constant: 10.0),
            
            NSLayoutConstraint(item: titleLabel,
                               attribute: .topMargin,
                               relatedBy: .equal,
                               toItem: self.imageView,
                               attribute: .topMargin,
                               multiplier: 1.0,
                               constant: 0.0),
            
            NSLayoutConstraint(item: titleLabel,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: self.contentView,
                               attribute: .trailing,
                               multiplier: 1.0,
                               constant: -12.0)
            
            ])
        
        NSLayoutConstraint.activate([
            
            NSLayoutConstraint(item: descriptionLabel,
                               attribute: .leadingMargin,
                               relatedBy: .equal,
                               toItem: titleLabel,
                               attribute: .leadingMargin,
                               multiplier: 1.0,
                               constant: 0.0),
            
            NSLayoutConstraint(item: descriptionLabel,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: self.titleLabel,
                               attribute: .bottom,
                               multiplier: 1.0,
                               constant: 8.0),
            
            NSLayoutConstraint(item: descriptionLabel,
                               attribute: .trailingMargin,
                               relatedBy: .equal,
                               toItem: self.titleLabel,
                               attribute: .trailingMargin,
                               multiplier: 1.0,
                               constant: 0.0)
            
            
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

