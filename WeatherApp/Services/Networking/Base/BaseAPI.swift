//
//  BaseAPI.swift
//  WeatherApp
//
//  Created by Abdulrahman  on 15/03/2024.
//

import Foundation
import Alamofire

open class BaseAPI<T: TargetType> {
    
    public init() { }
        
    public func fetchData<M: Codable>(target: T, interceptor: Interceptor = Interceptor(), responseClass: M.Type, completion: @escaping (Swift.Result<M, NetworkError>) -> Void) {

        guard Reachability.isConnectedToNetwork() else {
            completion(.failure(NetworkError.noInternetConnection))
            return
        }

        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let url = url(in: target)
        AF.request(url ,interceptor: interceptor) { urlR in
            urlR.method = method
            urlR.httpBody = target.body
            urlR.headers = headers
            NetworkLogger.log(request: urlR)
        }.validate(statusCode: 200...300)
            .responseData { (response) in
                self.handelResponse(response: response, completion: completion)
            }
    }
    
    
    func handelResponse<M: Decodable>(response: AFDataResponse<Data>, completion: @escaping (Swift.Result<M, NetworkError>) -> Void){
        NetworkLogger.log(data: response.data, response: response.response)
        switch response.result {
        case .success(let result):
            guard let responseObj = try? JSONDecoder().decode(M.self, from: result) else {
                completion(.failure(NetworkError.errorDecoding))
                return
            }
            completion(.success(responseObj))
        case .failure(let error):
            if let data = response.data {
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    let errorMessage = errorResponse.error.message
                    let error = NetworkError.customError(description: errorMessage)
                    completion(.failure(error))
                } catch {
                    completion(.failure(.unknownError))
                }
            } else {
                completion(.failure(.unknownError))
            }
        }
        
    }
    
    func url(in target: T) -> URL {
        let url = target.baseURL.appendingPathComponent(target.path)
        guard let urlParameters = target.urlParameters else { return url }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = urlParameters.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }
        return urlComponents?.url ?? url
    }
}

struct ErrorResponse: Codable {
    struct ErrorDetail: Codable {
        let message: String
        let code: Int
    }
    
    let error: ErrorDetail
}
