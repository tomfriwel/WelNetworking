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
        
        print(1)
        
        let task = URLSession.shared.dataTask(with: self.requestObject.request) { data, response, error in
            print(2)
            if let error = error {
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
            }
        }
        task.resume()
        
        
        print(3)
        if isCancelled {
            return
        }
        
    }
}
