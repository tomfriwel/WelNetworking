//
//  API.swift
//  NetworkDemo
//
//  Created by tomfriwel on 2018/12/3.
//  Copyright © 2018 tomfriwel. All rights reserved.
//

import Foundation

typealias Response = (NSDictionary?) -> Void
typealias ResponseError = (Any?) -> Void


class API:NSObject {
    var success:(Response)?
    var fail:(ResponseError)?
    
    // api
    static let serverUrl = "https://www.easy-mock.com/mock/5b9b22636a29d2427a5d90a6/apitest"
    
    enum movie:String {
        case getList = "/movie/getList"
    }
    
    enum book:String {
        case getList = "/movie/getList"
    }
    
    enum special:String {
        case getList = "/movie/getList",
        getCount = "/movie/getSpecialCount"
    }
    
    func map(baseurl: String)-> String {
        return "\(API.serverUrl)\(baseurl)"
    }
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
    
    func success(success: @escaping Response) {
        self.success = success
    }
    
    func fail(fail: @escaping ResponseError) {
        self.fail = fail
    }
    
    func run(baseurl: String, data:Dictionary<String, String> = [:], params:Dictionary<String, String> = [:]) -> Self {
        let urlString = self.map(baseurl: baseurl)
        self.post(url: urlString, data: data, params: params)
        return self
    }
    
    func post(url: String, data:Dictionary<String, String> = [:], params:Dictionary<String, String> = [:]) -> Void {
        var urlComponents = URLComponents(string: url)!
        
        if params.count>0 {
            urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        print(urlComponents.url?.absoluteString as Any)
        var request = URLRequest(url: urlComponents.url!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        if data.count>0 {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            } catch {
                self.fail?(error)
            }
        }
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
            
            if dict != nil {
                self.success?(dict! as NSDictionary)
            } else {
                self.fail?(responseString)
            }
        }
        task.resume()
    }
}
