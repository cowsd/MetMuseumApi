//
//  APIEndpoints.swift
//  MetMuseumApi
//
//  Created by Alex Pesenka on 29/11/24.
//

import Foundation

enum APIEndpoints {
        case searchPaintings
        case paintingDetails(id: Int)
        
        var url: URL {
            let baseURL = "https://collectionapi.metmuseum.org/public/collection/v1"
            switch self {
            case .searchPaintings:
                return URL(string: "\(baseURL)/search?hasImages=true&q=painting")!
            case .paintingDetails(let id):
                return URL(string: "\(baseURL)/objects/\(id)")!
            }
        }
    }
