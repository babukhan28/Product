//
//  APIManager.swift
//  Product
//
//  Created by Rajni on 05/05/23.
//

import Foundation

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case ivalidData
    case network(Error?)
}

//typealias ProductHandler = (Result<[ProductModel], DataError>) -> ()
typealias Handler<T> = (Result<T, DataError>) -> ()

//TODO: Singleton design pattern.
final class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    static var commonHeader: [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    func request<T: Decodable>(modelType: T.Type, type: EndPointType, completion: @escaping Handler<T >) {
        guard let url = type.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.method.rawValue
        
        if let body = type.body {
            request.httpBody = try? JSONEncoder().encode(body )
        }
        
        request.allHTTPHeaderFields = type.headers
                
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data, error == nil else {
                completion(.failure(.ivalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let products = try decoder.decode(modelType, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(.network(error)))
            }
        }.resume()
    }
}
 
