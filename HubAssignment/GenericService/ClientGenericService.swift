//
//  ClientGenericService.swift
//  HubAssignment
//
//  Created by Syed, Azharuddin on 1/17/19.
//  Copyright © 2019 Syed, Azharuddin. All rights reserved.
//

import Foundation

typealias SuccessCallBack = (_ data:Data?, _ response:URLResponse?) -> ()
typealias FailureCallBack = (_ data:Data?, _ response:URLResponse?, _ error:Error?) -> ()

enum HTTPMethodType: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    case update = "UPDATE"
}

class ClientGenericService: NSObject {
    
    func makeHTTPRequest(ofType type: HTTPMethodType, withRequest request:URLRequest, payload:[String:String]? = nil, successBlock:@escaping SuccessCallBack, failureBlock:@escaping FailureCallBack) {
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                failureBlock(data, response, error)
                return
            }
            
            successBlock(data, response)
        }
        dataTask.resume()
    }
}
