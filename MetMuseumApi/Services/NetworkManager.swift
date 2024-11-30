//
//  NetworkManager.swift
//  MetMuseumApi
//
//  Created by Alex Pesenka on 28/11/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No Error")
                return
            }
//            // Добавляем вывод JSON перед декодированием
//                   if let jsonString = String(data: data, encoding: .utf8) {
//                       print("JSON Response: \(jsonString)")
//                   }
            do {
                let dataModel = try JSONDecoder().decode(type, from: data)
                DispatchQueue.main.async{
                    completion(.success(dataModel))
                }
            } catch {
//                print("Decoding error: \(error)")
//                    if let jsonString = String(data: data, encoding: .utf8) {
//                        print("Failed JSON: \(jsonString)")
//                    }
                completion(.failure(.decodingError))
                
            }
        }.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    
}
