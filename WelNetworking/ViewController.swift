//
//  ViewController.swift
//  WelNetworking
//
//  Created by tomfriwel on 2018/12/3.
//  Copyright © 2018 tomfriwel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        _ = API().run(baseurl: API.book.getValue.rawValue, data: ["b":"a"], params: [:]).success(success: {resp in
            print(resp as Any)
        }).fail(fail: { error in
            print(error as Any)
        })
        
//        let op = RequestOperation(requestObject: RequestObject(urlString: "https://www.easy-mock.com/mock/5b9b22636a29d2427a5d90a6/apitest/book/getList"))
//        op.start()
    }
    
    
}

