//
//  Metrics.swift
//  HubAssignment
//
//  Created by Syed, Azharuddin on 1/18/19.
//  Copyright © 2019 Syed, Azharuddin. All rights reserved.
//

import Foundation

enum Metrics: String {
    case tmax = "Tmax"
    case tmin = "Tmin"
    case rainfall = "Rainfall"
    
    static var allKeys:[Metrics] = [.tmax, .tmin, .rainfall]
}

enum Location:String {
    case uk = "UK"
    case england = "England"
    case scotland = "Scotland"
    case wales = "Wales"

    static var allKeys:[Location] = [.uk, .england, .scotland, .wales]
}

