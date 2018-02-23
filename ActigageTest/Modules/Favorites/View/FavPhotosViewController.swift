//
//  FavPhotosViewController.swift
//  ActigageTest
//
//  Created by Durgesh Pandey on 19/12/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import UIKit
import Nuke
import KSToastView

class FavPhotosViewController: UIViewController {
    
    var presenter: FavPhotosPresentation!
    var favPhotos = [FavouritePhoto]()
    
    @IBOutlet weak var collectionViewFavPhotos: UICollectionView!
    @IBOutlet weak var viewNoContent: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Up View
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Get FavPhotos List
        presenter.getListOfFavPhotos()
    }
    
    func setUpView() {
        
        //set Navigation Bar
        setupNavigationBar()
        
        //Register Nibs
        self.collectionViewFavPhotos.register(UINib.init(nibName: "FlickerSearchGridCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FlickerSearchGridCollectionViewCell")
        
        //Set Dynamic Height of collection view cells
        if let flowLayout = self.collectionViewFavPhotos.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize.init(width: 1, height: 1)
        }
        
        //Set bounce always
        self.collectionViewFavPhotos.alwaysBounceVertical = true
    }
    
    func setupNavigationBar() {
        
        //Set Large Title for Navigation Bar
        self.title = "Favorites"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .never
        
        //Change Fontcolor for Large navigation Title
        let attributes = [NSAttributedStringKey.foregroundColor : UIColor.darkGray]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
}

extension FavPhotosViewController: FavPhotosView {
    
    func showFavPhotos(_ favPhotos: [FavouritePhoto]) {
        
        self.viewNoContent.isHidden = true
        self.collectionViewFavPhotos.isHidden = false
        
        self.favPhotos = favPhotos
        
        //Reload Collection
        self.collectionViewFavPhotos.reloadData()
    }
    
    func showNoContentScreen() {
        
        self.viewNoContent.isHidden = false
        self.collectionViewFavPhotos.isHidden = true
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
// MARK: -
extension FavPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.favPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let gridCollectionCell: FlickerSearchGridCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlickerSearchGridCollectionViewCell", for: indexPath) as! FlickerSearchGridCollectionViewCell
        
        let flickerPhotoModel = self.favPhotos[indexPath.row]
        gridCollectionCell.layoutConstraintViewWidth.constant = (collectionView.bounds.size.width/3) - 15
        gridCollectionCell.layoutConstraintViewHeight.constant = (collectionView.bounds.size.width/3) - 15
        
        //Add Border
        gridCollectionCell.contentView.layer.borderWidth = 0.5
        gridCollectionCell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        gridCollectionCell.contentView.layer.masksToBounds = true
        
        //Set Async Image
        Manager.shared.loadImage(with: URL.init(string: flickerPhotoModel.imageUrl!)!, into: gridCollectionCell.imageView)
        
        //Add Gesture Recognizer in Cell
        let longPressGestureRecognizer = UILongPressGestureRecognizer.init(target: self, action: #selector(removePhotoFromFavourite(sender:)))
        gridCollectionCell.tag = indexPath.row
        gridCollectionCell.addGestureRecognizer(longPressGestureRecognizer)
        
        return gridCollectionCell
        
    }
}

extension FavPhotosViewController {
    
    @objc func removePhotoFromFavourite(sender: UITapGestureRecognizer? = nil) {
        
        let alertCtrl = UIAlertController.init(title: "Alert", message: "Are you sure, You want to remove this photo from Favorites?", preferredStyle: .alert)
        
        alertCtrl.addAction(UIAlertAction.init(title: "Yes", style: .default, handler: { (alertAction) in
            
            if let selectedIndex = sender?.view?.tag {
                
                let selectedPhotoModel = self.favPhotos[selectedIndex]
                
                //Remove From Favorite
                if let selectedModel = DataBaseManager.sharedInstance.getFavoritePhoto(selectedPhotoModel.id!) {
                    
                    //Display Toast
                    KSToastView.ks_showToast("You removed \(selectedModel.title!) from favorites successfully.")
                    
                    //Delete From Core Data
                    DataBaseManager.sharedInstance.persistentContainer.viewContext.delete(selectedModel)
                    
                    //Save Context
                    DataBaseManager.sharedInstance.saveContext()
                    
                    //Get FavPhotos List
                    self.presenter.getListOfFavPhotos()
                    
                } else {
                    
                    //Display Toast
                    KSToastView.ks_showToast("You have already removed this photo from favorites")
                }
            }
        }))
        
        alertCtrl.addAction(UIAlertAction.init(title: "Cancel", style: .destructive, handler: { (alertAction) in
            
            //dismiss Alert
            alertCtrl.dismiss(animated: true, completion: {
            })
        }))
        
        //Present Alert
        self.present(alertCtrl, animated: true, completion: nil)
      
    }
}
