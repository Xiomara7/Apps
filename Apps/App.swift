//
//  App.swift
//  Apps
//
//  Created by Xiomara on 2/9/17.
//  Copyright © 2017 Xiomara. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias AppArray = [App]

class App {
    
    var name: String
    var summary: String
    var imageURL: String
    var category: String
    
    init?(json: JSON) {
        guard let name = json[keyName]["label"].string else {
            return nil
        }
        
        self.name = name
        
        guard let imageURL = json[keyImage].array?.first?["label"].string else {
            return nil
        }
        
        self.imageURL = imageURL
        
        guard let summary = json[keySummary]["label"].string else {
            return nil
        }
        
        self.summary = summary
        
        guard let category = json[keyCategory]["label"].string else {
            return nil
        }
        
        self.category = category
    }
    
}

extension App: Equatable { }

func ==(lhs: App, rhs: App) -> Bool {
    return lhs.name == rhs.name
}

