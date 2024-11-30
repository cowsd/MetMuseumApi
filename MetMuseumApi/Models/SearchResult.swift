//
//  SearchResponse.swift
//  NetworkingLesson
//
//  Created by Alex Pesenka on 05/09/24.
//

import Foundation

struct SearchResult: Decodable {
    let objectIDs: [Int]
}

struct Painting: Decodable {
    let title: String
    let artistDisplayName: String
    let primaryImageSmall: String?
    let objectDate: String
    let medium: String
    
    var safeTitle: String {
            title.isEmpty ? "N/A" : title
        }
        
        var safeArtistDisplayName: String {
            artistDisplayName.isEmpty ? "N/A" : artistDisplayName
        }
        
        var safeObjectDate: String {
            objectDate.isEmpty ? "N/A" : objectDate
        }
        
        var safeMedium: String {
            medium.isEmpty ? "N/A" : medium
        }
    
}
