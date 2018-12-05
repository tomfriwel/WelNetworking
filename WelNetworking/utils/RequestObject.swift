//
//  RequestObject.swift
//  WelNetworking
//
//  Created by tomfriwel on 2018/12/4.
//  Copyright © 2018 tomfriwel. All rights reserved.
//

import Foundation

typealias Response = (NSDictionary?) -> Void
typealias ResponseError = (Any?) -> Void

class RequestObject {
    enum State {
        case new, doing, done, cancel
    }
    let url:String
    var state = State.new
    var data:[String:Any]
    var params:[String:Any]
    var success:(Response)?
    var fail:(ResponseError)?
    
    lazy var request:URLRequest = {
        var urlComponents = URLComponents(string: self.url)!
        
        if params.count>0 {
            urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: ($0.value as! String)) }
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        return request
    }()
    
    init(url:String, data:[String:Any]=[:], params:[String: Any]=[:], run:Bool=true) {
        self.url = url
        self.data = data
        self.params = params
        
        if run {
            self.run()
        }
    }
    
    init(apiurl:String, data:[String:Any]=[:], params:[String: Any]=[:], run:Bool=true) {
        self.url = API.map(baseurl: apiurl)
        self.data = data
        self.params = params
        
        if run {
            self.run()
        }
    }
    
    func success(success:@escaping Response) -> Self {
        self.success = success
        return self
    }
    
    func fail(fail:@escaping ResponseError) -> Self {
        self.fail = fail
        return self
    }
    
    func run() -> Void {
        Network.post(reqeustObject: self)
    }
}
