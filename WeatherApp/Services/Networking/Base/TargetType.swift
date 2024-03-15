//
//  TargetType.swift
//  WeatherApp
//
//  Created by Abdulrahman  on 15/03/2024.
//

import Foundation
import Alamofire

public protocol TargetType {
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethods { get }
    var headers: [String: String]? { get }
    var urlParameters: [String: Any]? { get }
    var body: Data? { get }

}


public enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum NetworkError: Error, Equatable {
    case noInternetConnection
    case errorDecoding
    case unknownError
    case customError(description: String)

    public var errorDescription: String {
        switch self {
        case .noInternetConnection:
            return "No internet connection."
        case .errorDecoding:
            return "Error decoding data."
        case .unknownError:
            return "An unknown error occurred."
        case .customError(let description):
            return description
        }
    }
    
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.noInternetConnection, .noInternetConnection),
             (.errorDecoding, .errorDecoding),
             (.unknownError, .unknownError):
            return true
        case let (.customError(description1), .customError(description2)):
            return description1 == description2
        default:
            return false
        }
    }
}
