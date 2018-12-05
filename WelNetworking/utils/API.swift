//
//  API.swift
//  NetworkDemo
//
//  Created by tomfriwel on 2018/12/3.
//  Copyright © 2018 tomfriwel. All rights reserved.
//

import Foundation


class API {
    lazy var postsInProgress:[IndexPath: Operation] = [:]
    lazy var postQueue:OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Post queue"
        return queue
    }()
    
    // api
    static let serverUrl = "https://www.easy-mock.com/mock/5b9b22636a29d2427a5d90a6/apitest"
    
    enum movie:String {
        case getList = "/movie/getList"
    }
    
    enum book:String {
        case getList = "/movie/getList",
        getValue = "/movie/getValue"
    }
    
    enum special:String {
        case getList = "/movie/getList",
        getCount = "/movie/getSpecialCount"
    }
    
    static func map(baseurl: String)-> String {
        return "\(API.serverUrl)\(baseurl)"
    }
}
