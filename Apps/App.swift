//
//  App.swift
//  Apps
//
//  Created by Xiomara on 2/9/17.
//  Copyright © 2017 Xiomara. All rights reserved.
//

import UIKit

class App {
    
    var name: String?
    var summary: String?
    var imageURL: String?
    var category: String?
    
    init(name: String, summary: String, imageURL: String, category: String) {
        self.name = name
        self.summary = summary
        self.imageURL = imageURL
        self.category = category
    }
    
    class func cardsWithArray(dictionary: [String: AnyObject]) -> [App] {
        var apps = [App]()
        
        guard let feed = dictionary[keyFeed] as? [String: AnyObject] else { return apps }
        guard let entry = feed[keyEntry] as? [[String:AnyObject]] else { return apps }
        
        for item in entry {
            guard let nameEntry = item[keyName] as? [String: AnyObject] else { return apps }
            guard let imageEntry = item[keyImage] as? [[String: AnyObject]] else { return apps }
            guard let summaryEntry = item[keySummary] as? [String: AnyObject] else { return apps }
            guard let categoryEntry = item[keyCategory] as? [String: AnyObject] else { return apps }
            
            let name = nameEntry["label"] as? String
            let summary = summaryEntry["label"] as? String
            let imgString = imageEntry[0]["label"] as? String
            let category = categoryEntry["attributes"]?["label"] as? String
            
            let app = App(name: name!, summary: summary!, imageURL: imgString!, category: category!)
            apps.append(app)
        }
        
        return apps
    }

}
