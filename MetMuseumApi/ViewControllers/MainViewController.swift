//
//  ViewController.swift
//  NetworkingLesson
//
//  Created by Alex Pesenka on 05/09/24.
//

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet weak var objectTitle: UILabel!
    @IBOutlet weak var objectArtist: UILabel!
    @IBOutlet weak var objectDate: UILabel!
    @IBOutlet weak var objectMedium: UILabel!
    @IBOutlet weak var objectImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var showMoreButton: UIButton!
    
    private let networkManager = NetworkManager.shared
    private var artObjectsIDs: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showMoreButton.layer.cornerRadius = 10
        activityIndicator.startAnimating()
        fetchArtObjects()
    }
    
    @IBAction func showMoreTapped(_ sender: Any) {
        fetchNextValidObject()
    }
    
    
}


// MARK: - Networking
extension MainViewController {
    
    private func fetchArtObjects(){
        networkManager.fetch(SearchResult.self, from: APIEndpoints.searchArtObjects.url) { [weak self] result in
            switch result {
            case .success(let searchResult):
                self?.artObjectsIDs = searchResult.objectIDs
                self?.fetchNextValidObject()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchNextValidObject() {
        guard let randomArtObjectID = artObjectsIDs.randomElement() else {
            return
        }
        networkManager.fetch(ArtObject.self, from: APIEndpoints.objectDetails(id: randomArtObjectID).url) { [weak self] result in
            switch result {
            case .success(let artObject):
                guard let imageURL = artObject.primaryImageSmall, !imageURL.isEmpty else {
                    self?.fetchNextValidObject()
                    return
                }
                self?.updateUI(with: artObject)
                
            case .failure(let error):
                print("Failed to fetch art object details: \(error)")
            }
        }
    }
    
    private func fetchImage(from urlString: String?) {
        activityIndicator.startAnimating()
        
        guard
            let urlString, !urlString.isEmpty,
            let imageURL = URL(string: urlString)
        else {
            objectImage.image = UIImage(systemName: "photo")
            activityIndicator.stopAnimating()
            return
        }
        
        networkManager.fetchImage(from: imageURL) { [weak self] result in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
            switch result {
            case .success(let imageData):
                self?.objectImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
    
    private func updateUI(with artObject: ArtObject) {
        objectTitle.text = artObject.safeTitle
        objectArtist.text = artObject.safeArtistDisplayName
        objectDate.text = artObject.safeObjectDate
        objectMedium.text = artObject.safeMedium
        
        fetchImage(from: artObject.primaryImageSmall)
        
    }
    
    
}
