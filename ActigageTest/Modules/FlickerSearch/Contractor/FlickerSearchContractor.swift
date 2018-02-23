//
//  FlickerSearchContractor.swift
//  ActigageTest
//
//  Created by Durgesh Pandey on 18/12/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit

protocol FlickerSearchView: IndicatableView {
    
    var presenter: FlickerSearchPresentation! { get set }
    
    func showFlickerList(_ flickerSearchModel: [FlickerPhotoModel])
    func showNoContentScreen()
    func clearLastSearchedData()
}

protocol FlickerSearchPresentation: class {
    
    weak var view: FlickerSearchView? { get set }
    var interactor: FlickerSearchUseCase! { get set }
    var router: FlickerSearchWireframe! { get set }
    
    func viewDidLoad()
    func fetchFlickerPhotosList(for searchText: String)
}

protocol FlickerSearchUseCase: class {
    
    var output: FlickerSearchInteractorOutput! { get set }
    
    func fetchFlickerPhotosList(for searchText: String)
}

protocol FlickerSearchInteractorOutput: class {
    
    func flickerSearchListFetchedSuccessfully(_ flickerSearchModel: [FlickerPhotoModel])
    func flickerSearchListFetchFailed()
}

protocol FlickerSearchWireframe: class {
    
    weak var viewController: UIViewController? { get set }
    
    static func assembleModule() -> UIViewController
}
