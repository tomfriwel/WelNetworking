//
//  RequestObject.swift
//  WelNetworking
//
//  Created by tomfriwel on 2018/12/4.
//  Copyright © 2018 tomfriwel. All rights reserved.
//

import Foundation


class RequestObject {
    enum State {
        case new, doing, done, cancel
    }
    let urlString:String
    var state = State.new
    var data:[String:Any]
    var params:[String:Any]
    
    lazy var request:URLRequest = {
        var urlComponents = URLComponents(string: self.urlString)!
        
        if params.count>0 {
            urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: ($0.value as! String)) }
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        return request
    }()
    
    init(urlString:String, data:[String:Any]=[:], params:[String: Any]=[:]) {
        self.urlString = urlString
        self.data = data
        self.params = params
    }
}
