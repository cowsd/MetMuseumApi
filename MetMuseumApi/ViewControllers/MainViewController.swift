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
    @IBOutlet weak var placeholderStackView: UIStackView!
    
    private let networkManager = NetworkManager.shared
    private var paintings: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showMoreButton.setTitleColor(UIColor.lightGray, for: .disabled)
        showMoreButton.backgroundColor = UIColor.systemGray5
        showMoreButton.layer.cornerRadius = 8
        fetchPaintings { [weak self] in
            self?.fetchRandomPaintingDetails()
        }
    }
    
    @IBAction func showMoreTapped(_ sender: Any) {
        fetchRandomPaintingDetails()
    }
    
    
}


// MARK: - Networking
extension MainViewController {
    
    private func fetchPaintings(completion: @escaping () -> Void){
        networkManager.fetch(SearchResult.self, from: APIEndpoints.searchPaintings.url) { [weak self] result in
            switch result {
            case .success(let paintings):
                self?.paintings = paintings.objectIDs
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchRandomPaintingDetails() {
        showMoreButton.isEnabled = false
        guard let randomPainting = paintings.randomElement() else {
            showMoreButton.isEnabled = true
            return
        }
        networkManager.fetch(Painting.self, from: APIEndpoints.paintingDetails(id: randomPainting).url) { [weak self] result in
            self?.showMoreButton.isEnabled = true
            switch result {
            case .success(let painting):
//                print(painting)
                self?.updateUI(with: painting)
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func fetchImage(from urlString: String?) {
        activityIndicator.startAnimating()
        guard
            let urlString, !urlString.isEmpty,
            let imageURL = URL(string: urlString)
        else {
//            self.objectImage.image = UIImage(systemName: "photo")
            self.objectImage.image = nil
            self.objectImage.backgroundColor = .black
            self.placeholderStackView.alpha = 1
            activityIndicator.stopAnimating()
            return
        }
        self.placeholderStackView.alpha = 0
        networkManager.fetchImage(from: imageURL) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.objectImage.image = UIImage(data: imageData)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
    
    private func updateUI(with painting: Painting) {
        objectTitle.text = painting.safeTitle
        objectArtist.text = painting.safeArtistDisplayName
        objectDate.text = painting.safeObjectDate
        objectMedium.text = painting.safeMedium
        
        fetchImage(from: painting.primaryImageSmall)
    
    }
    
    
}
