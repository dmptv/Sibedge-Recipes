//
//  NetworkLayer.swift
//  Sibedge-Recipes
//
//  Created by 123 on 18.06.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit

typealias Json = [String: Any]

class ApiClient {
    private init(){}
    static let shared = ApiClient()
    typealias CompletionHandler = (Result) -> Void
    fileprivate var dataTask: URLSessionDataTask? = nil
    
    enum Result {
        case sucsess(Any?)
        case failure
    }
    
     public func loadData(_ completion: @escaping CompletionHandler) {
        
        dataTask?.cancel()
        
        let url = getUrl()
        let session = URLSession.shared
        dataTask = session.dataTask(with: url, completionHandler: { data, response, error in
            
            if let error = error as NSError?, error.code == -999 {
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data, let jsonDictionary = self.parse(json: jsonData) {
                completion(.sucsess(jsonDictionary))
            } else {
                completion(.failure)
            }
            
        })
        dataTask?.resume()
        
    }
    
    fileprivate func getUrl() -> URL {
        let urlString = String(format: "http://cdn.sibedge.com/temp/recipes.json")
        
        let url = URL(string: urlString)
        return url!
    }
    
    fileprivate func parse(json data: Data) -> Json? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? Json
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
    }
}














