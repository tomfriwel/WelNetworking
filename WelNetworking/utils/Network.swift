//
//  Network.swift
//  WelNetworking
//
//  Created by tomfriwel on 2018/12/5.
//  Copyright © 2018 tomfriwel. All rights reserved.
//

import Foundation

class Network {
    static func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    static func post(reqeustObject: RequestObject) -> Void {
        let task = URLSession.shared.dataTask(with: reqeustObject.request) { data, response, error in
            if let error = error {
                reqeustObject.fail?(error)
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                let responseString = String(data: data, encoding: .utf8)
                let dict = convertToDictionary(text: responseString!)
                reqeustObject.success?(dict! as NSDictionary)
            }
        }
        task.resume()
    }
}
