//
//  Network.swift
//  Employees
//
//  Created by Ramazan Abdulaev on 05.11.2022.
//

import Foundation

protocol NetworkProtocol {
    func request(searchTerm: String, completion: @escaping (Result<Data, Error>?) -> Void)
}

final class Network: NetworkProtocol {
    
    static let v4 = "v3"
    
    func request(searchTerm: String = "1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c", completion: @escaping (Result<Data, Error>?) -> Void) {
        let url = self.url(searchTerm: searchTerm)
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        let task = createDataTask(with: request, completion: completion)
        task.resume()
    }

    private func url(searchTerm: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "run.mocky.io"
        components.path = "/\(Network.v4)/\(searchTerm)"
        return components.url!
    }
    
    
    private func createDataTask(with request: URLRequest, completion: @escaping (Result<Data, Error>?) -> Void) -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data else { return }
                completion(.success(data))
            }
        }
        
    }
    
    
}

