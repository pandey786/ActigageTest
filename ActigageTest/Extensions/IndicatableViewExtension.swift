//
//  IndicatableViewExtension.swift
//  ActigageTest
//
//  Created by Durgesh Pandey on 18/12/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

extension IndicatableView where Self: UIViewController {
    
    func showActivityIndicator() {
        SVProgressHUD.show()
    }
    
    func hideActivityIndicator() {
        SVProgressHUD.dismiss()
    }
}
