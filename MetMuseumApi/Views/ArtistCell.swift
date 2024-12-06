//
//  ArtistCell.swift
//  MetMuseumApi
//
//  Created by Alex Pesenka on 04/12/24.
//

import Foundation
import UIKit

final class ArtistCell: UICollectionViewCell {
    
    @IBOutlet var artistImage: UIImageView!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var numberOfWorksLabel: UILabel!
    
    func configure(with artist: Artist) {
        
        artistNameLabel.text = artist.name
        numberOfWorksLabel.text = "\(artist.numberOfWorks) works"
        artistImage.image = UIImage(named: artist.imageName)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        artistImage.layer.cornerRadius = artistImage.frame.width / 2
    }
    
    func updateNumberOfWorks(to count: Int) {
            numberOfWorksLabel.text = "\(count) works"
        }
    
}


