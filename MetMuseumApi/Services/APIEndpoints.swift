//
//  APIEndpoints.swift
//  MetMuseumApi
//
//  Created by Alex Pesenka on 29/11/24.
//

import Foundation

enum APIEndpoints {
    case searchObjects
    case objectDetails(id: Int)
    
    
    
    var url: URL {
        let baseURL = "https://collectionapi.metmuseum.org/public/collection/v1"
        switch self {
        case .searchObjects:
            return URL(string: "\(baseURL)/search?hasImages=true&isHighlight=true&q=painting")!
        case .objectDetails(let id):
            return URL(string: "\(baseURL)/objects/\(id)")!
        }
    }
}

