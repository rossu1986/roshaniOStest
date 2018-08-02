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
        aboutCountryTableView.estimatedRowHeight = 100
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
        
        // Add Constraints
        addConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        /// Initialising AboutCountry ViewModel Class
        aboutContryViewModel = AboutCountryViewModel()
        
        //
        aboutCountryTableView.translatesAutoresizingMaskIntoConstraints = false
        aboutCountryTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        aboutCountryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        aboutCountryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        aboutCountryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        aboutCountryTableView.translatesAutoresizingMaskIntoConstraints = false
        
        /*
         Add Autolayout Constraints on TableCell fields
         
         - Add constraints with Visual Format Language
         
         */
        let viewsDictionary: [String: Any] = [
            "aboutCountryTableView": aboutCountryTableView]
        
        var allConstraints: [NSLayoutConstraint] = []
        
        /*
         Set Vertical and Horizontal constraints on table view cell attribute
         
         */
        
        /// For aboutCountryImgView
        let tableViewVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[aboutCountryTableView]-|",
            metrics: nil,
            views: viewsDictionary)
        allConstraints += tableViewVerticalConstraints
        
        
        let topRowHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[aboutCountryTableView]-|",
            metrics: nil,
            views: viewsDictionary)
        allConstraints += topRowHorizontalConstraints
        
        
        //NSLayoutConstraint.activate(allConstraints)
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Load datas
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
            self.refreshControl?.endRefreshing()
            DispatchQueue.main.async {
                /// Refresh table content data
                self.aboutCountryTableView.reloadData()
                
                /* Set navigation title for showing dynamic title name
                   from the API's response
                */
                self.title = self.aboutContryViewModel.aboutCountryName
            }
        }
    }
    
    /// Add layout Constraints programmatically to all the subviews
    fileprivate func addConstraints() {
        
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
        cell.aboutCountryImgView.loadImage(item.imageUrl)
        cell.aboutCountryTitleLabel.text = item.title
        cell.aboutCountryDescriptionLabel.text = item.des
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
