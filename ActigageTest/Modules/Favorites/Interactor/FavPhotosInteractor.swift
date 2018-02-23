//
//  FavPhotosInteractor.swift
//  ActigageTest
//
//  Created by Durgesh Pandey on 19/12/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation

class FavPhotosInteractor: FavPhotosUsecase {
    
    var output: FavPhotosInteractorOutput!
    
    func getListOfFavPhotos() {
        
        //Get All Fav Photos
        if let favPhotos = DataBaseManager.sharedInstance.getListOfAllFavoritePhotos() {
            
            //Fetched Successfully
            self.output.favPhotosFetchedSuccessfully(favPhotos)
            
        } else {
            
            //Fetch Failed
            self.output.favPhotosFetchFailed()
        }
    }
}
