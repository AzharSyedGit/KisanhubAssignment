//
//  Utility.swift
//  HubAssignment
//
//  Created by Syed, Azharuddin on 1/17/19.
//  Copyright © 2019 Syed, Azharuddin. All rights reserved.
//

import Foundation

class Utility {
    class func urls() -> [String:String] {
        guard let path = Bundle.main.path(forResource: "URL", ofType: "plist") else {
            print("Error while loading bundle for url.plist")
            return [:]
        }
        
        let dict = NSDictionary(contentsOfFile: path)!.toDict { (dict) -> (String, String) in
            guard let key = dict.key as? String else {
                fatalError("URL.plist dict.key is not String")
            }
            
            guard let value = dict.value as? String else {
                fatalError("Utility dict.value is not URL")
            }
            return (key, value)
        }
        
        return dict
    }
}
