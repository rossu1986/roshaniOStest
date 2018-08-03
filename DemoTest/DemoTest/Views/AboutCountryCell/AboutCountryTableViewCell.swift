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
    
    /// build array to store constraints
    var allConstraints: [NSLayoutConstraint] = []
    
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
        
        /// Create a views dictionary that holds string representations of views to resolve inside the format string.
        let viewsDictionary: [String: Any] = [
            "aboutCountryImgView": aboutCountryImgView,
            "aboutCountryTitleLabel": aboutCountryTitleLabel,
            "aboutCountryDescriptionLabel": aboutCountryDescriptionLabel]
        
        /*
         Set Vertical and Horizontal constraints on table view cell attribute
         
         */
        if #available(iOS 11.0, *) {
            
            /// In case of the rectangle-shaped phones, insets will be 0; the iPhone X however will have different values based on its orientation
            let newInsets = self.safeAreaInsets
            let leftMargin = newInsets.left > 0 ? newInsets.left : 0
            let rightMargin = newInsets.right > 0 ? newInsets.right : 0
            let topMargin = newInsets.top > 0 ? newInsets.top : 0
            let bottomMargin = newInsets.bottom > 0 ? newInsets.bottom : 0
            
            /*
               Metrics are a dictionary of number values that can appear inside the VFL format string
               -set the metrics parameter to the metrics dictionary
 
            */
            let metrics = [
                "topMargin": topMargin,
                "bottomMargin": bottomMargin,
                "leftMargin": leftMargin,
                "rightMargin": rightMargin]
            
            /// Set up vertical constraints for the about country title
            let titleLabelVerticalConstraints = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-[aboutCountryTitleLabel]",
                metrics: metrics,
                views: viewsDictionary)
            allConstraints += titleLabelVerticalConstraints
            
            /// Set up horizontal constraints for the about country title, placing its trailing edge from its about country image.
            let titleLabelHorizontalConstraints = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-[aboutCountryImgView]-[aboutCountryTitleLabel]",
                metrics: metrics,
                views: viewsDictionary)
            allConstraints += titleLabelHorizontalConstraints
            
            /// Set up vertical constraints for the about country description, placing its width greater than 75.
            let descriptionLabelVerticalConstraints = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-[aboutCountryTitleLabel]-[aboutCountryDescriptionLabel(>=75@500)]-|",
                metrics: metrics,
                views: viewsDictionary)
            allConstraints += descriptionLabelVerticalConstraints
            
            /// Set up horizontal constraints for the about country description, placing its trailing edge from its about country image.
            let descriptionLabelHorizontalConstraints = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-[aboutCountryImgView]-[aboutCountryDescriptionLabel]-|",
                metrics: metrics,
                views: viewsDictionary)
            allConstraints += descriptionLabelHorizontalConstraints
            
            /// Set up vertical constraints for the about country image, placing its height 100.
            let imageVerticalConstraints = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-[aboutCountryImgView(100@1000)]",
                metrics: metrics,
                views: viewsDictionary)
            allConstraints += imageVerticalConstraints
            
            /// Set up horizontal constraints for the about country image, placing its width 100.
            let imageHorizontalConstraints = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-[aboutCountryImgView(100@1000)]",
                metrics: metrics,
                views: viewsDictionary)
            allConstraints += imageHorizontalConstraints
            
        } else {
            // Fallback on earlier versions
            
            /// Set up vertical constraints for the about country title
            let titleLabelVerticalConstraints = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-[aboutCountryTitleLabel]",
                metrics: nil,
                views: viewsDictionary)
            allConstraints += titleLabelVerticalConstraints
            
            /// Set up horizontal constraints for the about country title, placing its trailing edge from its about country image.
            let titleLabelHorizontalConstraints = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-[aboutCountryImgView]-[aboutCountryTitleLabel]",
                metrics: nil,
                views: viewsDictionary)
            allConstraints += titleLabelHorizontalConstraints
            
            /// Set up vertical constraints for the about country description, placing its width greater than 75.
            let descriptionLabelVerticalConstraints = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-[aboutCountryTitleLabel]-[aboutCountryDescriptionLabel(>=75@500)]-|",
                metrics: nil,
                views: viewsDictionary)
            allConstraints += descriptionLabelVerticalConstraints
            
            /// Set up horizontal constraints for the about country description, placing its trailing edge from its about country image.
            let descriptionLabelHorizontalConstraints = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-[aboutCountryImgView]-[aboutCountryDescriptionLabel]-|",
                metrics: nil,
                views: viewsDictionary)
            allConstraints += descriptionLabelHorizontalConstraints
            
            /// Set up vertical constraints for the about country image, placing its height 100.
            let imageVerticalConstraints = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-[aboutCountryImgView(100@1000)]",
                metrics: nil,
                views: viewsDictionary)
            allConstraints += imageVerticalConstraints
            
            /// Set up horizontal constraints for the about country image, placing its width 100.
            let imageHorizontalConstraints = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-[aboutCountryImgView(100@1000)]",
                metrics: nil,
                views: viewsDictionary)
            allConstraints += imageHorizontalConstraints
        }
        
        /// Activate the layout constraints using the class method activate(_:) on NSLayoutConstraint by passing in the allConstraints array.
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
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
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
