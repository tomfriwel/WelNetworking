//
//  ViewController.swift
//  WelNetworking
//
//  Created by tomfriwel on 2018/12/3.
//  Copyright © 2018 tomfriwel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = RequestObject(apiurl: API.book.getList.rawValue).success(success: {data in
            print(data as Any)
            do {
                let str = String.init(data: try JSONSerialization.data(withJSONObject: data ?? [:], options: .prettyPrinted), encoding: .utf8)
                DispatchQueue.main.async {
                    self.displayLabel.text = str
                }
            } catch {
            }
        })
    }
    
    @IBAction func reload(_ sender: Any) {
        _ = RequestObject(apiurl: API.movie.getList.rawValue).success(success: {data in
            do {
                let str = String.init(data: try JSONSerialization.data(withJSONObject: data ?? [:], options: .prettyPrinted), encoding: .utf8)
                DispatchQueue.main.async {
                    self.displayLabel.text = str
                }
            } catch {
            }
        })
    }
}

