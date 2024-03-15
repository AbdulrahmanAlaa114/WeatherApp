//
//  File.swift
//  WeatherAppTests
//
//  Created by Abdulrahman  on 15/03/2024.
//

import Foundation
import Alamofire
@testable import WeatherApp

class MockBaseAPI<T: TargetType>: BaseAPI<T> {
    var stubbedResult: Result<Data, NetworkError>?
    var isFetchDataCalled = false

    override func fetchData<M: Codable>(target: T, interceptor: Interceptor = Interceptor(), responseClass: M.Type, completion: @escaping (Swift.Result<M, NetworkError>) -> Void) {
        isFetchDataCalled = true
        if let result = stubbedResult {
            switch result {
            case .success(let data):
                guard let responseObj = try? JSONDecoder().decode(M.self, from: data) else {
                    completion(.failure(NetworkError.errorDecoding))
                    return
                }
                completion(.success(responseObj))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    override func url(in target: T) -> URL {
        return URL(string: "")!
    }
}
