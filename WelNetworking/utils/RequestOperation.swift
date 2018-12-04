//
//  RequestOperation.swift
//  WelNetworking
//
//  Created by tomfriwel on 2018/12/4.
//  Copyright © 2018 tomfriwel. All rights reserved.
//

import Foundation

class RequestOperation: Operation {
    let requestObject:RequestObject
    
    init(requestObject:RequestObject) {
        self.requestObject = requestObject
        
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        
    }
}
