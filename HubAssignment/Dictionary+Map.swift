//
//  Dictionary+Map.swift
//  HubAssignment
//
//  Created by Syed, Azharuddin on 1/17/19.
//  Copyright © 2019 Syed, Azharuddin. All rights reserved.
//

import Foundation

extension NSDictionary {
    func toDict<K : Hashable, V>
        ( convert: (Element) -> (K, V)) -> [K:V] {
        var result: [K:V] = [:]
        for x in self {
            let (key, val) = convert(x)
            result[key] = val
        }
        return result
    }
}
