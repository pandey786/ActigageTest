//
//  RootRouter.swift
//  ActigageTest
//
//  Created by Durgesh Pandey on 18/12/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import UIKit

class RootRouter: RootWireframe {
    
    func presentHomeScreen(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = RootRouter.assembleModule()
    }
    
    static func assembleModule() -> UITabBarController {
        
        let view: RootViewController = rootStoryBoard.instantiateViewController(withIdentifier: "RootViewController") as! RootViewController
      
        //Create Child Controllers
        let flickerSearchCtrl = FlickerSearchRouter.assembleModule()
        flickerSearchCtrl.tabBarItem = UITabBarItem.init(tabBarSystemItem: .search, tag: 0)
        
        let favPhotosCtrl1 = FavPhotosRouter.assembleModule()
        favPhotosCtrl1.tabBarItem = UITabBarItem.init(tabBarSystemItem: .favorites, tag: 1)
        
        view.viewControllers = [flickerSearchCtrl, favPhotosCtrl1]
        
        return view
    }
}
