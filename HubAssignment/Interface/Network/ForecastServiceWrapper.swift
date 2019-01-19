//
//  ForecastServiceWrapper.swift
//  HubAssignment
//
//  Created by Syed, Azharuddin on 1/18/19.
//  Copyright © 2019 Syed, Azharuddin. All rights reserved.
//

import Foundation

class ForecastServiceWrapper: NSObject {
    @objc let forecastService: ForecastService
    
    @objc init(forecastService: ForecastService) {
        self.forecastService = forecastService
        super.init()
    }
    
    func getForeCast(forMetrics metrics: Metrics, location: Location, completion:@escaping  ([WeatherForecast]?)->Void) {
        forecastService.getForeCast(forMetrics: metrics, location: location, success: { (data, response) in
            
            guard let responseData = data else {
                completion(nil)
                return
            }
            
            do {
                let weatherForecast = try JSONDecoder().decode([WeatherForecast].self, from: responseData)
                completion(weatherForecast)
            }catch {
                print(error.localizedDescription)
                completion(nil)
            }
            
        }) { (data, response, error) in
            completion(nil)
        }
    }
}
