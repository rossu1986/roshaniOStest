//
//  AboutCountryViewController.swift
//  DemoTest
//
//  Created by Roshan on 7/31/18.
//  Copyright © 2018 Roshan Mishra. All rights reserved.
//

import UIKit
import SDWebImage

/**
 ViewController for Showing AboutCountry Data
 
 */

class AboutCountryViewController: UIViewController {
    var refreshControl: UIRefreshControl?
    var aboutContryViewModel : AboutCountryViewModel!
    var aboutCountryTableView: UITableView!
    
    /*
     
 
    */
    var allConstraints: [NSLayoutConstraint] = []
    
    // MARK: View Controller Life Cycle
    
    override func loadView() {
        super.loadView()
        
        
        /*
         Create custom UITableView by programatically i.e. aboutCountryTableView
         - Set the tableview data source and delegate
         - Added this table on UIView
         - Register custom tableview cell on aboutCountryTableView
         - AboutCountryTableViewCell.reusableIdentifer is cell identifer and is declared
           in AboutCountryTableViewCell
         */
        
        aboutCountryTableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        aboutCountryTableView.delegate      =   self
        aboutCountryTableView.dataSource    =   self
        aboutCountryTableView.register(AboutCountryTableViewCell.self, forCellReuseIdentifier: AboutCountryTableViewCell.reusableIdentifer)
        
        /*
         Initial we set the tableview cell size 100
         - Define cell size dynamic becuase each content size is different
         - Cell size depend upon AboutCountry model data i.e description attributes
         
         */
        aboutCountryTableView.rowHeight = UITableViewAutomaticDimension
        aboutCountryTableView.estimatedRowHeight = 120
        self.view.addSubview(self.aboutCountryTableView)
        
        /*
         Added pull to refresh feature for Refreshing the data from coming server
         - Added refresh control on aboutCountryTableView
         - Added refresh action method : refreshTableData
         - Refresh data when pull the tableview
 
        */
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshTableData), for: .valueChanged)
        refreshControl?.bringSubview(toFront: aboutCountryTableView)
        aboutCountryTableView.addSubview(refreshControl!)
        
        /// Visual format language for NSLayoutConstraint for autolayouting
        addConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        /// Initialising AboutCountry ViewModel Class
        aboutContryViewModel = AboutCountryViewModel()
     }
    
    /// Add layout Constraints programmatically to all the tableview
    fileprivate func addConstraints() {
        /*
         Set the property translatesAutoresizingMaskIntoConstraints to be false on each fields, because by default iOS generates Auto Layout constraints for you based on a view's size and position.
         
         - We'll be doing it by progrmatically, so we need to disable this feature.
         */
        aboutCountryTableView.translatesAutoresizingMaskIntoConstraints = false
        
        /*
         Add Autolayout Constraints on TableView
         
         */
        
        /// Create a views dictionary that holds string representations of views to resolve inside the format string.
        let viewsDictionary: [String: Any] = [
            "aboutCountryTableView": aboutCountryTableView]
        
        /// deactivated and removed when new constraints are required
        if !allConstraints.isEmpty {
            NSLayoutConstraint.deactivate(allConstraints)
            allConstraints.removeAll()
        }
        
        /// Set up vertical constraints for the tableView.
        let tableViewVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[aboutCountryTableView]-|",
            metrics: nil,
            views: viewsDictionary)
        allConstraints += tableViewVerticalConstraints
        
        /// Set up horizonal constraints for the tableView, placing its trailing and leading edge 0 points from its superview.
        let topRowHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[aboutCountryTableView]-0-|",
            metrics: nil,
            views: viewsDictionary)
        allConstraints += topRowHorizontalConstraints
        
        /// Activate the layout constraints using the class method activate(_:) on NSLayoutConstraint by passing in the allConstraints array.
        NSLayoutConstraint.activate(allConstraints)
    }
    
    /*
     For iPhoneX
     
     - view controllers will be notified by the viewSafeAreaInsetsDidChange() on safe area changes
 
    */
    
    override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.viewSafeAreaInsetsDidChange()
            
            /// deactivated and removed when new constraints are required
            if !allConstraints.isEmpty {
                NSLayoutConstraint.deactivate(allConstraints)
                allConstraints.removeAll()
            }
            
            /// Create a views dictionary that holds string representations of views to resolve inside the format string.
            let viewsDictionary: [String: Any] = [
                "aboutCountryTableView": aboutCountryTableView]
            
            /// In case of the rectangle-shaped phones, insets will be 0; the iPhone X however will have different values based on its orientation
            let newInsets = view.safeAreaInsets
            let leftMargin = newInsets.left > 0 ? newInsets.left : 0
            let rightMargin = newInsets.right > 0 ? newInsets.right : 0
            let topMargin = newInsets.top > 0 ? newInsets.top : 0
            let bottomMargin = newInsets.bottom > 0 ? newInsets.bottom : 0
            
            /// set the metrics parameter to the metrics dictionary
            let metrics = [
                "topMargin": topMargin,
                "bottomMargin": bottomMargin,
                "leftMargin": leftMargin,
                "rightMargin": rightMargin]
            
            /// Set up vertical constraints for the tableView, placing its top and bottom Margin   from its superview.
            let tableViewVerticalConstraints = NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-topMargin-[aboutCountryTableView]-bottomMargin-|",
                metrics: metrics,
                views: viewsDictionary)
            allConstraints += tableViewVerticalConstraints
            
            /// Set up horizonal constraints for the tableView, placing its trailing and leading edge 0 points from its superview.
            let topRowHorizontalConstraints = NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[aboutCountryTableView]-0-|",
                metrics: metrics,
                views: viewsDictionary)
            allConstraints += topRowHorizontalConstraints
            
            /// Activate the layout constraints using the class method activate(_:) on NSLayoutConstraint by passing in the allConstraints array.
            NSLayoutConstraint.activate(allConstraints)
            
        } 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// Load server datas
        self.getCountryDetails()
    }
    
    // MARK:- Refresh TableView Data
    
    @objc func refreshTableData() {
        self.getCountryDetails()
    }
    
    // MARK: Get CountryDetails from AboutCountryViewModel class
    
    @objc func getCountryDetails() -> Void {
        /*
         - Get the server records for AboutCountry Data from ViewModel i.e. AboutContryViewModel
         - Hide the refresh control activity once get the result
 
        */
        aboutContryViewModel.getAboutCountryData {
            DispatchQueue.main.async {
                /// End refresh control
                 self.refreshControl?.endRefreshing()
                
                /// Refresh table content data
                self.aboutCountryTableView.reloadData()
                
                /* Set navigation title for showing dynamic title name
                   from the API's response
                */
                self.title = self.aboutContryViewModel.aboutCountryName
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: UitableView Data Source and Delegate
extension AboutCountryViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aboutContryViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.aboutCountryTableView.dequeueReusableCell(withIdentifier: AboutCountryTableViewCell.reusableIdentifer) as! AboutCountryTableViewCell
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        let item: AboutCountry = aboutContryViewModel.getCountryRecord(indexPath: indexPath)
        
        // Set cell contents
        cell.aboutCountryImgView.image = nil
        cell.aboutCountryImgView.loadImage(item.imageUrl)
        cell.aboutCountryTitleLabel.text = item.title
        cell.aboutCountryDescriptionLabel.text = item.des
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
