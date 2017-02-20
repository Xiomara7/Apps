//
//  APIClient.swift
//  Apps
//
//  Created by Xiomara on 2/9/17.
//  Copyright © 2017 Xiomara. All rights reserved.
//

import Foundation
import BDBOAuth1Manager
import SwiftyJSON

// MARK: - API Client
class APIClient: BDBOAuth1SessionManager {
    
    struct URLHosts {
        static let prod = ""
        static let dev = "https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json"
    }
    
    struct Config {
        #if DEBUG
        static let URLString = URLHosts.dev
        #else
        static let URLString = URLHosts.prod
        #endif
    }
    
    static let shared = APIClient()

    // MARK: - API Client Methods
    func getTopApps(completion: ((AppArray?, Error?) -> ())?) {
        
        get(Config.URLString, parameters: nil, progress: nil, success: {(_, response) in
            let json = JSON(response!)
            var apps: AppArray?
            
            if let entriesJSON = json["feed"]["entry"].array {
                apps = AppArray()
                
                for entryJSON in entriesJSON  {
                    if let app = App(json: entryJSON) {
                        apps?.append(app)
                    }
                }
                
                completion?(apps, nil)
            } else {
                completion?(nil, NSError(domain: "error.domain", code: 0, userInfo: nil))
            }
            
        }) {(_, error) in
            completion?(nil, error)
        }

    }
}
