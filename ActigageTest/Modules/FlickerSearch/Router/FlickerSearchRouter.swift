//
//  FlickerSearchRouter.swift
//  ActigageTest
//
//  Created by Durgesh Pandey on 18/12/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit

class FlickerSearchRouter: FlickerSearchWireframe {
    
    var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        
        let view: FlickerSearchViewController = flickerSearchStoryBoard.instantiateViewController(withIdentifier: "FlickerSearchViewController") as! FlickerSearchViewController
        
        let interactor = FlickerSearchInteractor()
        let presenter = FlickerSearchPresenter()
        let router = FlickerSearchRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        interactor.output = presenter
        router.viewController = view
        
        return UINavigationController.init(rootViewController: view)
    }
}
