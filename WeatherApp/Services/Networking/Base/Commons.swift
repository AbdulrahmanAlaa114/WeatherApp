//
//  Commons.swift
//  WeatherApp
//
//  Created by Abdulrahman  on 15/03/2024.
//

import Foundation

public typealias JSONDictionary = [String: Any]

extension Data {
    
    var jsonDictionary: JSONDictionary? {
        let jsonObject = try? JSONSerialization.jsonObject(with: self, options: [])
        return jsonObject as? JSONDictionary
    }
    
    var arrayOfJsonDictionary: [JSONDictionary]? {
        let jsonObject = try? JSONSerialization.jsonObject(with: self, options: [])
        return jsonObject as? [JSONDictionary]
    }
}

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any  {
   var jsonString: String? {
      do {
         let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
         return String(bytes: data, encoding: .utf8)
      } catch {
         return nil
      }
   }
}

extension Encodable {
   func encode(using encoder: JSONEncoder = .init()) throws -> Data {
      return try encoder.encode(self)
   }
   
   func encode(using encoder: JSONEncoder = .init()) throws -> JSONDictionary? {
      let data: Data = try encode(using: encoder)
      return try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
   }
}

extension Encodable {
    
    func toData() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
}

extension Dictionary {
    
    func toData() -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let data = try? JSONSerialization.data(withJSONObject: self, options: [])
        return data
    }
}
