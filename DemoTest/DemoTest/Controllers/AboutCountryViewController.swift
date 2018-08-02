//
//  AboutCountryViewController.swift
//  DemoTest
//
//  Created by Roshan on 7/31/18.
//  Copyright © 2018 Roshan Mishra. All rights reserved.
//

import UIKit
import SDWebImage

class AboutCountryViewController: UIViewController {
    var refreshControl: UIRefreshControl?
    var aboutContryViewModel : AboutCountryViewModel!
    var aboutCountryTableView: UITableView!
    
    // MARK:- View Life Cycle
    
    override func loadView() {
        super.loadView()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(getCountryDetails), for: .valueChanged)
        refreshControl?.bringSubview(toFront: aboutCountryTableView)
        aboutCountryTableView.addSubview(refreshControl!)
        
        // Add Constraints
        addConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }

        // Initialising AboutCountry ViewModel Class
        aboutContryViewModel = AboutCountryViewModel()
        
        // Register a table view cell for displaying records
        
        view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Load datas
        self.getCountryDetails()
    }
    
    //MARK: Get CountryDetails from AboutCountryViewModel class
    @objc func getCountryDetails() -> Void {
        aboutContryViewModel.getAboutCountryData {
            self.refreshControl?.endRefreshing()
            DispatchQueue.main.async {
                
                //Set navigation title
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

// MARK: Data Source
