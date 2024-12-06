//
//  ArtistsViewController.swift
//  MetMuseumApi
//
//  Created by Alex Pesenka on 05/12/24.
//

import Foundation
import UIKit

final class ArtistsViewController: UICollectionViewController {
    
    private var artists = Artist.getArtists()
    private var worksNumberCache: [String: Int] = [:]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        artists.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "artistDetails", for: indexPath)
        guard let cell = cell as? ArtistCell else { return UICollectionViewCell() }
        let artist = artists[indexPath.item]
        cell.configure(with: artist)
        
        if let cachedNumber = worksNumberCache[artist.name] {
            cell.updateNumberOfWorks(to: cachedNumber)
        } else {
            fetchNumberOfWorks(for: artist) { numberOfWorks in
                print(Thread.isMainThread)
                self.worksNumberCache[artist.name] = numberOfWorks
                cell.updateNumberOfWorks(to: numberOfWorks)
            }
        }
        
        
        return cell
    }
}


// MARK: - Networking


private func fetchNumberOfWorks(for artist: Artist, completion: @escaping (Int) -> Void) {
    let url = APIEndpoints.searchByArtistName(artist.name).url
    NetworkManager.shared.fetch(SearchResult.self, from: url) { result in
        switch result {
        case .success(let searchResult):
            completion(searchResult.objectIDs.count)
        case .failure(let error):
            print("Error fetching number of works for \(artist.name): \(error)")
            completion(0)
        }
    }
}


