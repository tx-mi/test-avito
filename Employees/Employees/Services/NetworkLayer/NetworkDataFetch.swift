//
//  NetworkDataFetch.swift
//  Employees
//
//  Created by Ramazan Abdulaev on 05.11.2022.
//

import Foundation

protocol NetworkDataFetchProtocol {
    
    func fetchCompany(completion: @escaping (Result<Company, Error>?) -> Void)
    
}

final class NetworkDataFetch: NetworkDataFetchProtocol {
    
    private var networkService = Network()
    
    func fetchCompany(completion: @escaping (Result<Company, Error>?) -> Void) {
        var companyModel: CompanyModel?
        
        self.networkService.request() { results in
            switch results {
            case .success(let data):
                companyModel = self.decodeJSON(T: CompanyModel.self, from: data)
                guard let company = companyModel?.company else { return }
                completion(.success(company))
            case .some(.failure(let error)):
                completion(.failure(error))
            case .none:
                print("None")
            }
        }
        
    }
    
    private func decodeJSON<T: Decodable>(T: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(T.self, from: data)
            return objects
        } catch let error {
            print("Failed to decode JSON", error)
            return nil
        }
    }
    
}
