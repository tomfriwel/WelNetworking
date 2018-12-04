//
//  WelNetworking.swift
//  WelNetworking
//
//  Created by tomfriwel on 2018/12/4.
//  Copyright © 2018 tomfriwel. All rights reserved.
//

import Foundation

class WelNetworking {
    lazy var postsInProgress:[IndexPath: Operation] = [:]
    lazy var postQueue:OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Post queue"
        queue.maxConcurrentOperationCount = 1
        queue.isSuspended = true
        queue.qualityOfService = .utility
        return queue
    }()
    
    init(urlString:String, data:[String:Any]=[:], params:[String: Any]=[:]) {
    }
}
