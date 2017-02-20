//
//  AppDetailsController.swift
//  Apps
//
//  Created by Xiomara on 2/14/17.
//  Copyright © 2017 Xiomara. All rights reserved.
//

import UIKit

class AppDetailsController: UIViewController {

    var appShown: App!
    @IBOutlet weak var circle: UIImageView!
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var appSummary: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appImageView.layer.borderColor = UIColor.white.cgColor
        appImageView.layer.borderWidth = 1.0
        appImageView.layer.cornerRadius = 15.0
        appImageView.layer.masksToBounds = true
        
        UIView.animate(withDuration: 1.5, animations: {
            let scaleTransform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.circle.transform = scaleTransform
            self.circle.frame.origin.y = 64.0
        
            self.appImageView.setImageWith(URL(string: self.appShown.imageURL)!)
            self.appImageView.center = self.circle.center
            
        }, completion: { (finished: Bool) in
            self.appSummary.isHidden = false
            self.appSummary.text = self.appShown.summary
        })
    }
    
    @IBAction func onCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
