//
//  FavPhotosRouter.swift
//  ActigageTest
//
//  Created by Durgesh Pandey on 19/12/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit

class FavPhotosRouter: FavPhotosWireframe {
    
    var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        
        let view: FavPhotosViewController = favPhotosStoryBoard.instantiateViewController(withIdentifier: "FavPhotosViewController") as! FavPhotosViewController
        
        let interactor = FavPhotosInteractor()
        let presenter = FavPhotosPresenter()
        let router = FavPhotosRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        router.viewController = view
        
        return UINavigationController.init(rootViewController: view)
    }
}
