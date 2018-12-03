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
        // Do any additional setup after loading the view, typically from a nib.
        let api = API()
        api.post(url:"", data: ["b":"a"], params: [:]){ (responseObject:NSDictionary?, error:NSError?) in
            if ((error) != nil) {
                print("Error logging you in!")
            } else {
                print(responseObject as Any)
            }
        }
    }
    
    
}

