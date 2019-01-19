//
//  ClientGenericServiceWrapper.swift
//  HubAssignment
//
//  Created by Syed, Azharuddin on 1/17/19.
//  Copyright © 2019 Syed, Azharuddin. All rights reserved.
//

import Foundation

//Fascade Design Pattern

class ClientGenericServiceWrapper: NSObject {
    let clientGenericService: ClientGenericService
    
    @objc init(clientGenericService: ClientGenericService) {
        self.clientGenericService = clientGenericService
        super.init()
    }
    
    //Get
    func makeHttpGet(withRequest request: URLRequest, successBlock:@escaping SuccessCallBack, failureBlock:@escaping FailureCallBack) {
        clientGenericService.makeHTTPRequest(ofType: .get, withRequest: request, successBlock: successBlock, failureBlock: failureBlock)
    }
    
    //Post
    //Put
    //Delete
}
