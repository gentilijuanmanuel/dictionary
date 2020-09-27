//
//  NetworkManager.swift
//  Dictionary
//
//  Created by Juan Manuel Gentili on 13/09/2020.
//  Copyright © 2020 Juan Manuel Gentili. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    // MARK: - Static
    public static let shared = NetworkManager()
    
    // MARK: - Funcs
    func searchDefinition(word: String, completion: @escaping (_ success: Response?, _ error: String?) -> ()) {
        let url = URL(string: "https://owlbot.info/api/v4/dictionary/\(word)")
        
        guard let unwrapedUrl = url else {
            completion(nil, "We had a problem :(")
            return
        }
        
        var request = URLRequest(url: unwrapedUrl)
        request.httpMethod = "GET"
        request.setValue("Token ", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let _ = error {
                completion(nil, "We had a problem :(")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    completion(nil, "Error with the response, unexpected status code: \(String(describing: response))")
                    return
            }
            
            if let data = data,
                let definition = try? JSONDecoder().decode(Response.self, from: data) {
                completion(definition, nil)
            }
        })

        task.resume()
    }
}
