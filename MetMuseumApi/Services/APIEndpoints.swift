//
//  APIEndpoints.swift
//  MetMuseumApi
//
//  Created by Alex Pesenka on 29/11/24.
//

import Foundation

enum APIEndpoints {
    case searchArtObjects
    case objectDetails(id: Int)
    case searchByArtistName(String)
    
    
    
    var url: URL {
        let baseURL = "https://collectionapi.metmuseum.org/public/collection/v1"
        switch self {
        case .searchArtObjects:
            return URL(string: "\(baseURL)/search?hasImages=true&isHighlight=true&q=painting")!
        case .objectDetails(let id):
            return URL(string: "\(baseURL)/objects/\(id)")!
        case .searchByArtistName(let name):
            let encodedName = name.replacingOccurrences(of: " ", with: "%20")
            return URL(string: "\(baseURL)/search?q=\(encodedName)")!
        }
    }
}
