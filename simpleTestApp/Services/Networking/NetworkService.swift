//
//  NetworkService.swift
//  simpleTestApp
//
//  Created by Шамиль Моллачиев on 26.07.2023.
//

import Alamofire
import UIKit

protocol NetworkDataProvider {
}

typealias GetAllAutoResult = (Result<[AllAutoResponse], AFError>) -> Void
typealias GetAutoInfoResult = (Result<AutoInfoResponse, AFError>) -> Void
typealias GetAutoPostsResult = (Result<AutoPostsResponse, AFError>) -> Void

enum RequestGenerator: Codable {
    case getAllAuto(page: String)
    case getAutoInfo(autoId: String)
    case getAllPosts(autoId: String, page: String)
    
    var request: URLRequest {
        switch self {
        case .getAllAuto(let page):
            return requestCreator(basicURL: getAllAutoUrl(), method: .get) { components in
                injectPage(page: page, in: &components)
            }
        case .getAutoInfo(let autoId):
            return requestCreator(basicURL: getAutoInfoURL(id: autoId), method: .get) { _ in }
        case .getAllPosts(let autoId, let page):
            return requestCreator(basicURL: getAutoPosts(id: autoId), method: .get) { components in
                injectPage(page: page, in: &components)
            }
        }
    }
    
    /// метод сборки реквеста
    private func requestCreator(basicURL: String,
                                method: HTTPMethod,
                                injecton: ((inout URLComponents) -> Void)?) -> URLRequest {
        guard var components = URLComponents( string: basicURL) else {
            fatalError("FatalError")
        }
        
        injecton?(&components)
        
        guard let url = components.url else {
            fatalError("Error resolving URL")
        }
        
        var request = URLRequest(url: url)
        request.method = method
        return request
    }
    
    private func getAllAutoUrl() -> String {
        return "http://am111.05.testing.place/api/v1/cars/list"
    }
    
    private func getAutoInfoURL(id: String) -> String {
        return "http://am111.05.testing.place/api/v1/car/\(id)"
    }
    
    private func getAutoPosts(id: String) -> String {
        return "http://am111.05.testing.place/api/v1/car/\(id)/posts"
    }

    private func injectPage(page: String, in components: inout URLComponents) {
        let queries: [URLQueryItem] = [
            .init(name: "page", value: page)
        ]
        insert(queries: queries, components: &components)
    }
    
    private func insert(queries: [URLQueryItem], components: inout URLComponents) {
        if components.queryItems == nil {
            components.queryItems = queries
        } else {
            components.queryItems?.append(contentsOf: queries)
        }
    }
}

final class NetworkEngine {
    
    private func performDecodableRequest<T: Decodable>(
        request: RequestGenerator,
        completion: @escaping ((Result<T, AFError>) -> Void)
    ) {
        let decoder = createDecoder()
        AF.request(request.request)
            .validate()
            .responseDecodable(of: T.self) { result in
                guard let data = result.value else {
                    if let error = result.error {
                        completion(.failure(error))
                    }
                    return
                }
                
                completion(.success(data))
            }
    }
    
    private func createDecoder() -> JSONDecoder {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }
}

extension NetworkEngine: NetworkDataProvider {
    func getAllAuto(page: String, completion: @escaping GetAllAutoResult) {
        performDecodableRequest(request: .getAllAuto(page: page), completion: completion)
    }
    
    func getAutoInfo(autoId: String, completion: @escaping GetAutoInfoResult) {
        performDecodableRequest(request: .getAutoInfo(autoId: autoId), completion: completion)
    }

    func getAutoPosts(autoId: String, page: String, completion: @escaping GetAutoPostsResult) {
        performDecodableRequest(request: .getAllPosts(autoId: autoId, page: page), completion: completion)
    }
}
