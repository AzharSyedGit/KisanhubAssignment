//
//  ApplicationAssembly.swift
//  HubAssignment
//
//  Created by Syed, Azharuddin on 1/17/19.
//  Copyright © 2019 Syed, Azharuddin. All rights reserved.
//

import Foundation
import Typhoon

@objcMembers class ApplicationAssembly: TyphoonAssembly {
    dynamic var coreNetworkAssembly: CoreNetworkAssembly!
    dynamic var coreMemoryAssembly: CoreMemoryAssembly!
    
    
    open dynamic func forecastVC() -> AnyObject {
        return TyphoonDefinition.withClass(ForecastVC.self) {
            definition in
            
            definition!.injectProperty(#selector(getter: ForecastVC.forecastServiceWrapper), with: self.coreNetworkAssembly.forecastServiceWrapper())
            definition!.injectProperty(#selector(getter: ForecastVC.coreDataStack), with: self.coreMemoryAssembly.coreDataStack())
            } as AnyObject
    }
    
}
