//
//  API.swift
//  NetworkDemo
//
//  Created by tomfriwel on 2018/12/3.
//  Copyright © 2018 tomfriwel. All rights reserved.
//

import Foundation

typealias ServiceResponse = (NSDictionary?, NSError?) -> Void

class API {
//    https://stackoverflow.com/questions/30480672/how-to-convert-a-json-string-to-a-dictionary
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    public func post(url: String, data:Dictionary<String, String> = [], params:Dictionary<String, String> = [], onCompletion: @escaping ServiceResponse) -> Void{
        var url = URLComponents(string: "https://www.easy-mock.com/mock/5b9b22636a29d2427a5d90a6/apitest/movie/getList")!
        
        url.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        var request = URLRequest(url: url.url!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
//        let postString = "id=13&name=Jack"
//        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            let dict = self.convertToDictionary(text: responseString!)
            
            onCompletion(dict! as NSDictionary, nil)
        }
        task.resume()
    }
}
