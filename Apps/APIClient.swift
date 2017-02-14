//
//  APIClient.swift
//  Apps
//
//  Created by Xiomara on 2/9/17.
//  Copyright © 2017 Xiomara. All rights reserved.
//

import Foundation
import BDBOAuth1Manager

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

    func getTopApps(success:@escaping ([App]) -> (), failure:@escaping (Error) ->()) {
        get(Config.URLString, parameters: nil, progress: nil, success: {(_, response) in
            let apps = App.cardsWithArray(dictionary: response as! [String:AnyObject])
            success(apps)
            
        }) {(_, error) in
            
            print("error: \(error)")
            
            failure(error)
        }

    }
}
