//
//  NetworkManager.swift
//  MetMuseumApi
//
//  Created by Alex Pesenka on 28/11/24.
//

import Foundation
import Alamofire


final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchSearchObjects(from url: URL, completion: @escaping (Result<SearchResult, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: SearchResult.self) { dataResponse in
                switch dataResponse.result {
                    case .success(let searchObjects):
                    completion(.success(searchObjects))
                case .failure(let error):
                    completion(.failure(error))
                    print(error)
                }
            }
    }
    
    func fetchArtObject(from url: URL, completion: @escaping (Result<ArtObject, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: ArtObject.self) { dataResponse in
                switch dataResponse.result {
                    case .success(let artObject):
                    completion(.success(artObject))
                case .failure(let error):
                    completion(.failure(error))
                    print(error)
                }
            }
    }
    
    
    func fetchData(from url: URL, completion: @escaping (Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { responseData in
                switch responseData.result {
                    case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    
//    func fetchImage(from url: URL, completion: @escaping (Result<Data, AFError>)) -> Void {
//        
//    }
    
    
//    func fetchImage(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
//        DispatchQueue.global().async {
//            guard let imageData = try? Data(contentsOf: url) else {
//                DispatchQueue.main.async {
//                    completion(.failure(.noData))
//                }
//                return
//            }
//            DispatchQueue.main.async {
//                completion(.success(imageData))
//            }
//        }
//    }
    
    
}
