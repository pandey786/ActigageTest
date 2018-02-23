//
//  FlickerSearchViewController.swift
//  ActigageTest
//
//  Created by Durgesh Pandey on 18/12/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import UIKit
import Nuke
import KSToastView

enum EnumPhotoListMode: Equatable {
    case grid
    case row
}

class FlickerSearchViewController: UIViewController {
    
    var presenter: FlickerSearchPresentation!
    var flickerPhotoResults = [FlickerPhotoModel]()
    var viewMode: EnumPhotoListMode = .grid
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionViewFlickerSearch: UICollectionView!
    @IBOutlet weak var viewNoContent: UIView!
    
    //Search Controller
    let searchController = UISearchController.init(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Up View
        setUpView()
        
    }
    
    func setUpView() {
        
        //set Navigation Bar
        setupNavigationBar()
        
        //set up Search Controller
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        
        //Register Nibs
        self.collectionViewFlickerSearch.register(UINib.init(nibName: "FlickerSearchGridCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FlickerSearchGridCollectionViewCell")
        self.collectionViewFlickerSearch.register(UINib.init(nibName: "FlickerSearchListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FlickerSearchListCollectionViewCell")
        
        //Set Dynamic Height of collection view cells
        if let flowLayout = self.collectionViewFlickerSearch.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize.init(width: 1, height: 1)
        }
    }
    
    func setupNavigationBar() {
        
        //Set Large Title for Navigation Bar
        self.title = "Flicker Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .never
        
        //Change Fontcolor for Large navigation Title
        let attributes = [NSAttributedStringKey.foregroundColor : UIColor.darkGray]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
    func fetchFlickerPhotosList(for searchText: String) {
        
        clearLastSearchedData()
        presenter?.fetchFlickerPhotosList(for: searchText)
    }
    
    @IBAction func segmentedControlSegmentChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.viewMode = .grid
        case 1:
            self.viewMode = .row
        default:
            break
        }
        
        //Reload Collection
        self.collectionViewFlickerSearch.reloadData()
        
        //Scroll To top
        self.collectionViewFlickerSearch.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
    }
    
}

extension FlickerSearchViewController: FlickerSearchView {
    
    func showFlickerList(_ flickerSearchModel: [FlickerPhotoModel]) {
        
        self.viewNoContent.isHidden = true
        self.collectionViewFlickerSearch.isHidden = false
        
        self.flickerPhotoResults = flickerSearchModel
        self.collectionViewFlickerSearch.reloadData()
    }
    
    func showNoContentScreen() {
        
        self.viewNoContent.isHidden = false
        self.collectionViewFlickerSearch.isHidden = true
    }
    
    func clearLastSearchedData() {
        
        self.viewNoContent.isHidden = true
        self.collectionViewFlickerSearch.isHidden = false
        
        //Remove current records and remove from UI as well
        self.flickerPhotoResults.removeAll()
        self.collectionViewFlickerSearch.reloadData()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
// MARK: -
extension FlickerSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.flickerPhotoResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch viewMode {
        case .grid:
            
            let gridCollectionCell: FlickerSearchGridCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlickerSearchGridCollectionViewCell", for: indexPath) as! FlickerSearchGridCollectionViewCell
            
            let flickerPhotoModel = self.flickerPhotoResults[indexPath.row]
            gridCollectionCell.layoutConstraintViewWidth.constant = (collectionView.bounds.size.width/3) - 15
            gridCollectionCell.layoutConstraintViewHeight.constant = (collectionView.bounds.size.width/3) - 15
            
            //Add Border
            gridCollectionCell.contentView.layer.borderWidth = 0.5
            gridCollectionCell.contentView.layer.borderColor = UIColor.lightGray.cgColor
            gridCollectionCell.contentView.layer.masksToBounds = true
            
            //Set Async Image
            Manager.shared.loadImage(with: URL.init(string: flickerPhotoModel.getImageDownloadUrl())!, into: gridCollectionCell.imageView)
            
            //Add Gesture Recognizer in Cell
            let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(markPhotoAsFavourite(sender:)))
            tapGestureRecognizer.numberOfTapsRequired = 2
            gridCollectionCell.tag = indexPath.row
            gridCollectionCell.addGestureRecognizer(tapGestureRecognizer)
            
            return gridCollectionCell
        case .row:
            
            let listCollectionCell: FlickerSearchListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlickerSearchListCollectionViewCell", for: indexPath) as! FlickerSearchListCollectionViewCell
            
            let flickerPhotoModel = self.flickerPhotoResults[indexPath.row]
            
            listCollectionCell.layoutConstraintViewWidth.constant = (collectionView.bounds.size.width) - 20
            
            /*
             if let imageSize = listCollectionCell.imageView.image?.size {
             let imageWidth = imageSize.width
             let imageHeight = (listCollectionCell.layoutConstraintViewWidth.constant * imageSize.height) / imageWidth
             listCollectionCell.layoutConstraintViewHeight.constant = imageHeight
             } else {
             */
            
            listCollectionCell.layoutConstraintViewHeight.constant = 180 //Default height
            listCollectionCell.labelTitle.text = (flickerPhotoModel.title != nil) ? flickerPhotoModel.title: ""
            
            //Add Border
            listCollectionCell.contentView.layer.borderWidth = 0.5
            listCollectionCell.contentView.layer.borderColor = UIColor.lightGray.cgColor
            listCollectionCell.contentView.layer.masksToBounds = true
            
            //Set Async Image
            Manager.shared.loadImage(with: URL.init(string: flickerPhotoModel.getImageDownloadUrl())!, into: listCollectionCell.imageView)
            
            //Add Gesture Recognizer in Cell
            let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(markPhotoAsFavourite(sender:)))
            tapGestureRecognizer.numberOfTapsRequired = 2
            listCollectionCell.tag = indexPath.row
            listCollectionCell.addGestureRecognizer(tapGestureRecognizer)
            
            return listCollectionCell
        }
    }
}

extension FlickerSearchViewController {
    
    @objc func markPhotoAsFavourite(sender: UITapGestureRecognizer? = nil) {
        
        if let selectedIndex = sender?.view?.tag {
            
            let selectedPhotoModel = self.flickerPhotoResults[selectedIndex]
            
            //Mark This as Favorite
            if DataBaseManager.sharedInstance.getFavoritePhoto(selectedPhotoModel.id!) != nil {
                
                //Display Toast
                KSToastView.ks_showToast("You have already bookmarked this photo")
            } else {
                
                //Save photo in Fav
                DataBaseManager.sharedInstance.savePhotoInFavoriteList(selectedPhotoModel)
                
                //Display Toast
                KSToastView.ks_showToast("You saved \(selectedPhotoModel.title!) successfully.")
            }
        }
    }
}

// MARK: - Search Controller
// MARK: -
extension FlickerSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //Fetch Train Route
        guard let searchtext = searchController.searchBar.text else {
            return
        }
        
        if searchtext.count > 0 {
            
            //Fetch Route
            self.fetchFlickerPhotosList(for: searchtext)
        } else {
            
            //Present Alert
            let alertCtrl = UIAlertController.init(title: "Alert", message: "Please Enter Something to Search", preferredStyle: .alert)
            alertCtrl.addAction(UIAlertAction.init(title: "Ok", style: .destructive, handler: { (alertAction) in
                
                //Dismiss Alert
                alertCtrl.dismiss(animated: true, completion: {
                })
            }))
            
            self.present(alertCtrl, animated: true, completion: {
            })
        }
    }
}
