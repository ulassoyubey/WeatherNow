//
//  RestManager.swift
//  WeatherNow
//
//  Created by ulas soyubey on 25.05.2022.
//

import Foundation
import Alamofire
import AlamofireImage


protocol APIRouteable: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get set }
    var encoding: ParameterEncoding { get }
    
}

extension APIRouteable {
    var baseURL: String { return URLs.baseURL }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL().appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    mutating func addQueryParameter(key:String,value:String){
        if let _ = parameters {
            parameters?[key] = value
        }
    }
}

class RestManager {
    static var shared = RestManager()
    
    private init(){}
    
    func sendRequest<T: Decodable>(_ apiRoute: APIRouteable,
                     completion: @escaping (Result<T,AFError>) -> Void) {
            let dataRequest = AF.request(apiRoute)
            dataRequest
                .validate(statusCode: 200..<300)
                .responseDecodable(completionHandler: {  [weak dataRequest] (response: DataResponse<T,AFError>) in
                    dataRequest.map { debugPrint($0) }
                    switch response.result {
                    case .success(let response):
                        completion(.success(response))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
        }

}
