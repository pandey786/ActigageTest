//
//  FavPhotosContactor.swift
//  ActigageTest
//
//  Created by Durgesh Pandey on 19/12/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit

protocol FavPhotosView: IndicatableView {
    
    var presenter: FavPhotosPresentation! { get set }
    
    func showFavPhotos(_ favPhotos: [FavouritePhoto])
    func showNoContentScreen()
}

protocol FavPhotosPresentation: class {
    
    weak var view: FavPhotosView? { get set }
    var interactor: FavPhotosUsecase! { get set }
    var router: FavPhotosWireframe! { get set }
    
    func viewDidLoad()
    func getListOfFavPhotos()
}

protocol FavPhotosUsecase: class {
    
    var output: FavPhotosInteractorOutput! { get set }
    
    func getListOfFavPhotos()
}


protocol FavPhotosInteractorOutput: class {
    
    func favPhotosFetchedSuccessfully( _ favPhotos: [FavouritePhoto])
    func favPhotosFetchFailed()
}


protocol FavPhotosWireframe: class {
    
    weak var viewController: UIViewController? { get set }
    
    static func assembleModule() -> UIViewController
}
