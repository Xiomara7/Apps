//
//  SplashView.swift
//  Apps
//
//  Created by Xiomara on 2/12/17.
//  Copyright © 2017 Xiomara. All rights reserved.
//

import UIKit

class SplashView: UIView {

    @IBOutlet weak var circle: UIView!
    @IBOutlet weak var appleImage: UIImageView!

    let startingColor = UIColor(red: (80.0/255.0), green: (226.0/255.0), blue: (194.0/255.0), alpha: 1.0)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.becomeFirstResponder()
        
        circle.layer.borderColor = startingColor.cgColor
        circle.layer.borderWidth = 2.0
        circle.layer.cornerRadius = 25.0
        
        UIView.animate(withDuration: 2.0, animations: { () -> Void in
            let scaleTransform = CGAffineTransform(scaleX: 5.0, y: 5.0)
            
            self.circle.backgroundColor = UIColor.clear
            self.circle.transform = scaleTransform
            
            self.appleImage.center = self.center
        })
    }
}
