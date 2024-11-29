//
//  ViewController.swift
//  NetworkingLesson
//
//  Created by Alex Pesenka on 05/09/24.
//

import UIKit

final class MainViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPaintings()
    }
    
}

// MARK: - Networking
extension MainViewController {
    
    private func fetchPaintings(){
        networkManager.fetch(Paintings.self, from: APIEndpoints.searchPaintings.url) { result in
            switch result {
            case .success(let paintings):
                print(paintings)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
