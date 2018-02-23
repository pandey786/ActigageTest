//
//  FlickerSearchListCollectionViewCell.swift
//  ActigageTest
//
//  Created by Durgesh Pandey on 19/12/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import UIKit

class FlickerSearchListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var layoutConstraintViewWidth: NSLayoutConstraint!
    @IBOutlet weak var layoutConstraintViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
