//
//  CategoriesView.swift
//  Apps
//
//  Created by Xiomara on 2/14/17.
//  Copyright © 2017 Xiomara. All rights reserved.
//

import UIKit
import PureLayout

protocol CategoriesViewProtocol {
    func didCategoryChanged(category: String)
}

class CategoriesView: UIView {

    var delegate: CategoriesViewProtocol?
    var shouldUpdateConstraints = true
    
    let Categories = ["Productivity",
                      "Music",
                      "Entertainment",
                      "Photo & Video",
                      "Social Netwroking",
                      "Utilities",
                      "Navigation",
                      "Games",
                      "Shopping",
                      "Travel"]
    
    override func updateConstraints() {
        if shouldUpdateConstraints {
            for category in Categories {
                let button = UIButton(frame: CGRect.zero)
                button.setBackgroundImage(UIImage(named: "circleFilled"), for: .normal)
                button.setTitleColor(UIColor.white, for: .normal)
                button.titleLabel?.adjustsFontSizeToFitWidth = true
                button.setTitle(category, for: .normal)
                
                button.addTarget(self, action: #selector(didTapButton(sender:)), for: .allTouchEvents)
                
                self.addSubview(button)
            }
            
            let subviews = CGFloat(self.subviews.count / 2)
            let screenSize = UIScreen.main.bounds
            var currentX: CGFloat = 0.0
            
            for view in self.subviews {
                view.autoSetDimension(.width, toSize: (screenSize.width) / subviews)
                view.autoSetDimension(.height, toSize: (screenSize.width) / subviews)
                view.autoAlignAxis(toSuperviewAxis: .horizontal)
                view.autoPinEdge(toSuperviewEdge: .left, withInset: currentX)
                
                currentX += (screenSize.width) / subviews
            }
            shouldUpdateConstraints = false
        }
        super.updateConstraints()
    }
    
    func didTapButton(sender: UIButton) {
        self.delegate?.didCategoryChanged(category: sender.titleLabel!.text!)
    }
}
