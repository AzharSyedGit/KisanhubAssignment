//
//  CoreMemoryAssembly.swift
//  HubAssignment
//
//  Created by Syed, Azharuddin on 1/18/19.
//  Copyright © 2019 Syed, Azharuddin. All rights reserved.
//

import UIKit
import Typhoon

@objcMembers class CoreMemoryAssembly: TyphoonAssembly {
    
    open dynamic func coreDataStack() -> AnyObject {
        return TyphoonDefinition.withClass(CoreDataStack.self) { defination in
            defination?.scope = .singleton
            } as AnyObject
    }
}
