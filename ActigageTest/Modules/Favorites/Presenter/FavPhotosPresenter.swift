//
//  FavPhotosPresenter.swift
//  ActigageTest
//
//  Created by Durgesh Pandey on 19/12/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation

class FavPhotosPresenter: FavPhotosPresentation {
    
    var view: FavPhotosView?
    var interactor: FavPhotosUsecase!
    var router: FavPhotosWireframe!
    
    var favPhotos = [FavouritePhoto]()
    
    func viewDidLoad() {
        
    }
    
    func getListOfFavPhotos() {
     
        view?.showActivityIndicator()
        interactor.getListOfFavPhotos()
    }
}

extension FavPhotosPresenter: FavPhotosInteractorOutput {
    
    func favPhotosFetchedSuccessfully(_ favPhotos: [FavouritePhoto]) {
        self.favPhotos = favPhotos
        view?.hideActivityIndicator()
        view?.showFavPhotos(self.favPhotos)
    }
    
    func favPhotosFetchFailed() {
        view?.hideActivityIndicator()
        view?.showNoContentScreen()
    }
}
