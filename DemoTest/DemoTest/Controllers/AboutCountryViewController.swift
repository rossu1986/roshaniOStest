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
    var collectionView: UICollectionView!
    
    // MARK:- View Life Cycle
    
    override func loadView() {
        super.loadView()
        
        // Add subviews
        let flowLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isPrefetchingEnabled = true
        view.addSubview(collectionView)
        self.collectionView = collectionView
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(getCountryDetails), for: .valueChanged)
        refreshControl?.bringSubview(toFront: collectionView)
        collectionView.addSubview(refreshControl!)
        
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
        
        // Register a collection view cell for displaying records
        collectionView.register(AboutCountryCollectionViewCell.self, forCellWithReuseIdentifier: AboutCountryCollectionViewCell.reusableIdentifer)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
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
                self.collectionView.reloadData()
                
                //Set navigation title
                self.title = self.aboutContryViewModel.aboutCountryName
            }
        }
    }
    
    /// Add layout Constraints programmatically to all the subviews
    fileprivate func addConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                self.collectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
                self.collectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
                ])
        } else {
            // Fallback on earlier versions
            NSLayoutConstraint.activate([
                
                NSLayoutConstraint(item: collectionView,
                                   attribute: .leading,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .leading,
                                   multiplier: 1.0,
                                   constant: 0.0),
                
                NSLayoutConstraint(item: collectionView,
                                   attribute: .trailing,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .trailing,
                                   multiplier: 1.0,
                                   constant: 0.0),
                
                NSLayoutConstraint(item: collectionView,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .top,
                                   multiplier: 1.0,
                                   constant: 0.0),
                
                NSLayoutConstraint(item: collectionView,
                                   attribute: .bottom,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .bottom,
                                   multiplier: 1.0,
                                   constant: 0.0)
                
                
                ])

        }
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: Data Source
extension AboutCountryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return aboutContryViewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutCountryCollectionViewCell.reusableIdentifer, for: indexPath) as! AboutCountryCollectionViewCell
        
        // Set informations on Cell
        let item: AboutCountry = aboutContryViewModel.getCountryRecord(indexPath: indexPath)
        
        cell.imageView.loadImage(item.imageUrl)
        cell.titleLabel.text = item.title
        cell.descriptionLabel.text = item.des
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        let height: CGFloat = 90
        return CGSize(width: width, height:height)
    }
    
    // PreFetching
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let item: AboutCountry = aboutContryViewModel.getCountryRecord(indexPath: indexPath)
            
            // Prefetch data even before the cell is shown
            let urlString = item.imageUrl
            if let url = URL(string: urlString) {
                SDWebImagePrefetcher.shared().prefetchURLs([url])
            }
        }
    }
    
}

