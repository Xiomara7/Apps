//
//  AppCell.swift
//  Apps
//
//  Created by Xiomara on 2/13/17.
//  Copyright © 2017 Xiomara. All rights reserved.
//

import UIKit

class AppCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var appImageVIew: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15.0
        self.layer.borderColor = UIColor.white.cgColor
        
        self.sendSubview(toBack: appImageVIew)
        
        appImageVIew.layer.borderWidth = 1
        appImageVIew.layer.cornerRadius = 15.0
        appImageVIew.layer.masksToBounds = true
        appImageVIew.layer.borderColor = UIColor.white.cgColor
    }
}
