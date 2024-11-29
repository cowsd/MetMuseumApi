//
//  SearchResponse.swift
//  NetworkingLesson
//
//  Created by Alex Pesenka on 05/09/24.
//

import Foundation

struct Paintings: Decodable {
    let total: Int
    let objectIDs: [Int]
}

struct ArtObject: Decodable {
    let objectID: Int
    let title: String
    let artistDisplayName: String
    let primaryImageSmall: String
    let objectDate: String
}
