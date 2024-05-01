//
//  DataManager.swift
//  KuruTest
//
//  Created by Kuru on 2024-04-30.
//

import Foundation

class DataManager {
   
    func fetchItems(headers: [String: String]?, completion: @escaping (Result<[NewsModel], Error>) -> Void) {
        guard let url = URL(string: "https://api.restful-api.dev/objects") else {
            let error = NSError(domain: "Invalid URL", code: -1, userInfo: nil)
            completion(.failure(error))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Set headers if provided
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check for HTTP response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                let error = NSError(domain: "Server Error", code: statusCode, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            // Check for data
            guard let data = data else {
                let error = NSError(domain: "No Data", code: -1, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            do {
                // Parse JSON data
                let items = try JSONDecoder().decode([NewsModel].self, from: data)
                completion(.success(items))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
