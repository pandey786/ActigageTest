//
//  FlickerSearchPresenter.swift
//  ActigageTest
//
//  Created by Durgesh Pandey on 18/12/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation

class FlickerSearchPresenter: FlickerSearchPresentation {
    
    var view: FlickerSearchView?
    var interactor: FlickerSearchUseCase!
    var router: FlickerSearchWireframe!
    
    var flickerPhotoResults = [FlickerPhotoModel]()
    
    func viewDidLoad() {
        
    }
    
    func fetchFlickerPhotosList(for searchText: String) {
        
        view?.showActivityIndicator()
        interactor.fetchFlickerPhotosList(for: searchText)
    }
}

extension FlickerSearchPresenter: FlickerSearchInteractorOutput {
    
    func flickerSearchListFetchedSuccessfully(_ flickerSearchModel: [FlickerPhotoModel]) {
        
        self.flickerPhotoResults = flickerSearchModel
        
        view?.hideActivityIndicator()
        view?.showFlickerList(self.flickerPhotoResults)
    }
    
    func flickerSearchListFetchFailed() {
        view?.hideActivityIndicator()
        view?.showNoContentScreen()
    }

}
