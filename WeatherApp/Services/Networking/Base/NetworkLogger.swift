//
//  NetworkLogger.swift
//  WeatherApp
//
//  Created by Abdulrahman  on 15/03/2024.
//

import Foundation

enum NetworkLogger {
    
    static func log(request: URLRequest) {
    #if DEBUG
        print("\n- - - - - - - - - - OUTGOING - - - - - - - - - -\n")
        defer { print("\n- - - - - - - - - - END - - - - - - - - - -\n") }
        
        let urlString = request.url?.absoluteString ?? ""
        let urlComponents = URLComponents(string: urlString)
        
        let scheme = urlComponents?.scheme ?? ""
        let host = urlComponents?.host ?? ""
        let method = request.httpMethod ?? ""
        let headers = request.allHTTPHeaderFields?.jsonString ?? "N/A"
        let path = urlComponents?.path ?? ""
        let query = urlComponents?.query ?? ""
        
        var logOutput = """
      \(scheme)://\(host) \n
      \(method) \(path)\(query.isEmpty ? "" : "?")\(query)\n
      Headers: \(headers)
      """
        
        guard let httpBody = request.httpBody else {
            print(logOutput)
            return
        }
        
        if let json = httpBody.jsonDictionary?.jsonString {
            logOutput += "\n\nBody: \(json)"
        } else if let parameters = String(bytes: httpBody, encoding: .utf8) {
            logOutput += "\nBody: \n\(parameters)"
        }
        
        print(logOutput)
    #endif
    }
    
    static func log(data: Data?, response: HTTPURLResponse?) {
    #if DEBUG
        print("\n- - - - - - - - - - INGOING - - - - - - - - - -\n")
        defer { print("\n- - - - - - - - - - END - - - - - - - - - -\n") }
        
        let urlString = response?.url?.absoluteString ?? ""
        let urlComponents = URLComponents(string: urlString)
        
        let path = urlComponents?.path ?? "N/A"
        
        let body = convertDataToJSONString(data) ?? "N/A"
        
        let logOutput = """
      Path:\n\(path)\n
      StatusCode: \(String(describing: response?.statusCode))\n
      Body:\n\(body)
      """
        print(logOutput)
    #endif
    }
    
    static func convertDataToJSONString(_ data: Data?) -> String? {
        guard let data = data else { return nil }
        do {
            // Try to convert the data to a dictionary or array of dictionaries
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            // Check if the result is a dictionary
            if let jsonDictionary = jsonObject as? [String: Any] {
                // Convert the dictionary to JSON data
                let jsonData = try JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
                
                // Convert the JSON data to a string
                return String(data: jsonData, encoding: .utf8)
            }
            
            // Check if the result is an array of dictionaries
            if let jsonArray = jsonObject as? [[String: Any]] {
                // Convert the array to JSON data
                let jsonData = try JSONSerialization.data(withJSONObject: jsonArray, options: .prettyPrinted)
                
                // Convert the JSON data to a string
                return String(data: jsonData, encoding: .utf8)
            }
            
            // If the result is not a dictionary or array of dictionaries, return nil
            return nil
        } catch {
            print("Error converting data to JSON: \(error)")
            return nil
        }
    }
    
}
