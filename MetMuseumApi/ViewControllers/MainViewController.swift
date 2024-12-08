//
//  ViewController.swift
//  NetworkingLesson
//
//  Created by Alex Pesenka on 05/09/24.
//

import UIKit

final class MainViewController: UIViewController {
    
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mediumLabel: UILabel!
    @IBOutlet weak var objectImage: UIImageView!
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var buttonActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var showMoreButton: UIButton!
    
    // MARK: - Private Properties
    
    private let networkManager = NetworkManager.shared
    private var artObjectsIDs: [Int] = []
    
    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        imageActivityIndicator.startAnimating()
        view.backgroundColor = .black
        showMoreButton.layer.cornerRadius = 10
        fetchArtObjectIDs()
    }
    
    // MARK: - IB Actions
    
    @IBAction func showMoreTapped(_ sender: Any) {
        showLoadingStateForButton()
        fetchRandomArtObjectWithImage()
    }
}


// MARK: - Private Methods: Networking
extension MainViewController {
    
    private func fetchArtObjectIDs(){
        networkManager.fetch(SearchResult.self, from: APIEndpoints.searchObjects.url)
        { [weak self] result in
            
            switch result {
            case .success(let searchResult):
                self?.artObjectsIDs = searchResult.objectIDs
                self?.fetchRandomArtObjectWithImage()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchRandomArtObjectWithImage() {
        imageActivityIndicator.startAnimating()
        guard let randomIndex = artObjectsIDs.indices.randomElement() else {
            return
        }
        let randomArtObjectID = artObjectsIDs[randomIndex]
        
        networkManager.fetch(ArtObject.self, from: APIEndpoints.objectDetails(id: randomArtObjectID).url)
        { [weak self] result in

            switch result {
            case .success(let artObject):
                guard let imageURL = artObject.primaryImageSmall, !imageURL.isEmpty else {
                    self?.artObjectsIDs.remove(at: randomIndex)
                    self?.fetchRandomArtObjectWithImage()
                    return
                }
                self?.fetchImage(for: artObject)
                
            case .failure(let error):
                print("Failed to fetch art object details: \(error)")
                self?.fetchRandomArtObjectWithImage()
            }
        }
    }
    
    private func fetchImage(for artObject: ArtObject) {
        guard
            let imageURLString = artObject.primaryImageSmall,
            let imageURL = URL(string: imageURLString)
        else {
            fetchRandomArtObjectWithImage()
            return
        }
        
        networkManager.fetchImage(from: imageURL) { [weak self] result in
            switch result {
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else {
                    self?.updateUI(with: artObject, image: UIImage(systemName: "photo"))
                    return
                }
                self?.updateUI(with: artObject, image: image)
            case .failure(let error):
                print(error)
                self?.updateUI(with: artObject, image: UIImage(systemName: "photo"))
                
            }
        }
        
    }
    
}


// MARK: - Private Methods: UI

extension MainViewController {
    private func showLoadingStateForButton() {
        showMoreButton.isEnabled = false
        showMoreButton.backgroundColor = .systemGray5
        showMoreButton.setTitle("", for: .normal)
        buttonActivityIndicator.startAnimating()
        
    }
    
    private func hideLoadingStateForButton() {
        buttonActivityIndicator.stopAnimating()
        showMoreButton.setTitle("Show More", for: .normal)
        showMoreButton.isEnabled = true
        showMoreButton.backgroundColor = .white
        
    }
    
    private func updateUI(with artObject: ArtObject, image: UIImage?) {
        titleLabel.text = artObject.safeTitle
        artistLabel.text = artObject.safeArtistDisplayName
        dateLabel.text = artObject.safeObjectDate
        mediumLabel.text = artObject.safeMedium
        objectImage.image = image
        imageActivityIndicator.stopAnimating()
        hideLoadingStateForButton()
    }
    
}
