//
//  ForecastService.swift
//  HubAssignment
//
//  Created by Syed, Azharuddin on 1/18/19.
//  Copyright © 2019 Syed, Azharuddin. All rights reserved.
//

import Foundation

class ForecastService: NSObject {
    @objc var clientGenericServiceWrapper: ClientGenericServiceWrapper
    @objc var forecastURL: String
    
    @objc init(clientGenericServiceWrapper: ClientGenericServiceWrapper, forecastURL: String) {
        self.clientGenericServiceWrapper = clientGenericServiceWrapper
        self.forecastURL = forecastURL
        super.init()
    }
    
    func getForeCast(forMetrics metrics: Metrics, location: Location, success: @escaping SuccessCallBack, failure: @escaping FailureCallBack) {
        let urlString = forecastURL + "/\(metrics.rawValue)" + "-\(location.rawValue).json"
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "INVALID_URL", code: 900, userInfo: nil)
            failure(nil, nil, error)
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        clientGenericServiceWrapper.makeHttpGet(withRequest: request, successBlock: success, failureBlock: failure)
    }
}
