//
//  CoreNetworkAssembly.swift
//  HubAssignment
//
//  Created by Syed, Azharuddin on 1/18/19.
//  Copyright © 2019 Syed, Azharuddin. All rights reserved.
//

import UIKit
import Typhoon

@objcMembers class CoreNetworkAssembly: TyphoonAssembly {
    fileprivate var urls:[String: String] {
        get {
            return Utility.urls()
        }
    }
    
   open dynamic func clientGenericService()  -> AnyObject {
        return TyphoonDefinition.withClass(ClientGenericService.self) {
            (definition) in
            definition?.scope = .singleton
            } as AnyObject
    }
    
   open dynamic func clientGenericServiceWrapper() -> AnyObject {
        return TyphoonDefinition.withClass(ClientGenericServiceWrapper.self) {
            (definition) in
            
            definition?.useInitializer(#selector(ClientGenericServiceWrapper.init(clientGenericService:))) {
                (initializer) in
                
                initializer?.injectParameter(with: self.clientGenericService())
            }
            definition?.scope = .singleton
            } as AnyObject
    }
    
    open dynamic func forecastService() -> AnyObject {
        return TyphoonDefinition.withClass(ForecastService.self) {
            (definition) in
            
            definition?.useInitializer(#selector(ForecastService.init(clientGenericServiceWrapper:forecastURL:))) {
                (initializer) in
                
                initializer?.injectParameter(with: self.clientGenericServiceWrapper())
                initializer?.injectParameter(with: self.urls["forecastURL"])
            }
            definition?.scope = .singleton
            } as AnyObject
    }
    
    open dynamic func forecastServiceWrapper() -> AnyObject {
        return TyphoonDefinition.withClass(ForecastServiceWrapper.self) {
            (definition) in
            
            definition?.useInitializer(#selector(ForecastServiceWrapper.init(forecastService:))) {
                (initializer) in
                
                initializer?.injectParameter(with: self.forecastService())
            }
            definition?.scope = .singleton
            } as AnyObject
    }
    
}
