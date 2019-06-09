//
//  HTTPHandler.swift
//  movie-finder
//
//  Created by Dustin Waldron on 6/8/19.
//  Copyright © 2019 Dustin Waldron. All rights reserved.
//

import Foundation

public typealias CompletionHandler = (_ data: Data?) -> ()

class HTTPHandler {
    static func getJson(fromUrlString: String, completionHandler: @escaping CompletionHandler) {
        let urlString = fromUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)
        
        print("URL being used is: \(url!)")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if let data = data {
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                if statusCode == 200 {
                    print("return to completion handler with data")
                    return completionHandler(data as Data)
                }
            } else if let error = error {
                print("***There was an error making HTTP request***")
                print(error.localizedDescription)
                return completionHandler(nil)
            }
        }
        task.resume()
    }
}
