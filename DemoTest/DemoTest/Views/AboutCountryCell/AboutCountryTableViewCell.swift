//
//  AboutCountryTableViewCell.swift
//  DemoTest
//
//  Created by Roshan on 8/2/18.
//  Copyright © 2018 Roshan Mishra. All rights reserved.
//

import UIKit

/**
 Created about country tableView cell class
 
 - This cell class use in AboutCountryViewController
 - Purpose of this class is showing the table contents
 
 */


class AboutCountryTableViewCell: UITableViewCell {
    
    /**
     This is the attribute for showing on table view cell
     
     imgView: showing about country image on cell
     titleLabel: showing about country title on cell
     descriptionLabel: showing about country description on cell
 
    */
    var aboutCountryImgView: UIImageView!
    var aboutCountryTitleLabel: UILabel!
    var aboutCountryDescriptionLabel: UILabel!
    
    
    /// tableView cell identifier for reusing the cell
    static var reusableIdentifer = "cell"
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        /// call custom attribute method
        commonInit()
        
        /*
         Set the property translatesAutoresizingMaskIntoConstraints to be false on each fields, because by default iOS generates Auto Layout constraints for you based on a view's size and position.
         
         - We'll be doing it by progrmatically, so we need to disable this feature.
         */
        aboutCountryImgView.translatesAutoresizingMaskIntoConstraints = false
        aboutCountryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutCountryDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        /*
         Add Autolayout Constraints on TableCell fields
         
         - Add constraints with Visual Format Language
         
         */
        /// build dinctionary of views
        let viewsDictionary: [String: Any] = [
            "aboutCountryImgView": aboutCountryImgView,
            "aboutCountryTitleLabel": aboutCountryTitleLabel,
            "aboutCountryDescriptionLabel": aboutCountryDescriptionLabel]
        
        /// build array to store constraints
        var allConstraints: [NSLayoutConstraint] = []
        
        /*
         Set Vertical and Horizontal constraints on table view cell attribute
         
         */
        
        /// For aboutCountryImgView
        let imageVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-10-[aboutCountryImgView(100)]-|",
            metrics: nil,
            views: viewsDictionary)
        allConstraints += imageVerticalConstraints
        
        /// For AboutCountryTitleLabel
        let titleLabelVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[aboutCountryTitleLabel]",
            metrics: nil,
            views: viewsDictionary)
        allConstraints += titleLabelVerticalConstraints
        
        /// aboutCountryDescriptionLabel
        let descriptionLabelVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[aboutCountryTitleLabel]-[aboutCountryDescriptionLabel]",
            metrics: nil,
            views: viewsDictionary)
        allConstraints += descriptionLabelVerticalConstraints
        
        let titleLabelHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[aboutCountryImgView]-[aboutCountryTitleLabel]-15-|",
            metrics: nil,
            views: viewsDictionary)
        allConstraints += titleLabelHorizontalConstraints
        
        let descriptionLabelHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[aboutCountryImgView(100)]-[aboutCountryDescriptionLabel]-15-|",
            metrics: nil,
            views: viewsDictionary)
        allConstraints += descriptionLabelHorizontalConstraints
        
        
        NSLayoutConstraint.activate(allConstraints)
       
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /*
     Created custom attribute fields by progrmatically

     - imageView for displaying AboutCountry Image
     - titleLabel for displaying AboutCountry title
     - descriptionLabel for displaying AboutCountry description
 
    */
    
    private func commonInit() {
        let imgView = UIImageView(frame: .zero)
        imgView.contentMode = .scaleAspectFit
        imgView.backgroundColor = .lightGray
        self.contentView.addSubview(imgView)
        self.aboutCountryImgView = imgView
        
        let titleLabel = UILabel(frame:  .zero)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
        titleLabel.font = UIFont.systemFont(ofSize: 14.0)
        self.contentView.addSubview(titleLabel)
        self.aboutCountryTitleLabel = titleLabel
        
        let descriptionLabel = UILabel(frame:  .zero)
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
        descriptionLabel.font = UIFont.systemFont(ofSize: 13.0)
        self.contentView.addSubview(descriptionLabel)
        self.aboutCountryDescriptionLabel = descriptionLabel
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
