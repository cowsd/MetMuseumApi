//
//  Artist.swift
//  MetMuseumApi
//
//  Created by Alex Pesenka on 06/12/24.
//

import Foundation


struct Artist {
    let name: String
    var numberOfWorks: Int
    let imageName: String
    
    static func getArtists() -> [Artist] {
        [
            Artist(name: "Leonardo da Vinci", numberOfWorks: 0, imageName: "daVinci"),
            Artist(name: "Michelangelo", numberOfWorks: 0, imageName: "michelangelo"),
            Artist(name: "Raphael", numberOfWorks: 0, imageName: "raphael"),
            Artist(name: "Claude Monet", numberOfWorks: 0, imageName: "monet"),
            Artist(name: "Edgar Degas", numberOfWorks: 0, imageName: "degas"),
            Artist(name: "Vincent van Gogh", numberOfWorks: 0, imageName: "vangogh"),
            Artist(name: "Paul Cézanne", numberOfWorks: 0, imageName: "cezanne"),
            Artist(name: "Pablo Picasso", numberOfWorks: 0, imageName: "picasso"),
            Artist(name: "Salvador Dalí", numberOfWorks: 0, imageName: "dali"),
            Artist(name: "Kazimir Malevich", numberOfWorks: 0, imageName: "malevich"),
            Artist(name: "Wassily Kandinsky", numberOfWorks: 0, imageName: "kandinsky"),
            Artist(name: "William Turner", numberOfWorks: 0, imageName: "turner"),
            Artist(name: "John Constable", numberOfWorks: 0, imageName: "constable"),
            Artist(name: "Gustave Courbet", numberOfWorks: 0, imageName: "courbet"),
            Artist(name: "Jackson Pollock", numberOfWorks: 0, imageName: "pollock"),
            
            
        ]
    }
}
