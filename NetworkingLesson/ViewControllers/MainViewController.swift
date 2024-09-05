//
//  ViewController.swift
//  NetworkingLesson
//
//  Created by Alex Pesenka on 05/09/24.
//

import UIKit

final class MainViewController: UITableViewController {
    
    private let quoteURL = URL(string: "https://zenquotes.io/api/quotes")!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuote()
    }
    
}

// MARK: - Networking
extension MainViewController {
    private func fetchQuote() {
        URLSession.shared.dataTask(with: quoteURL) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let quote = try decoder.decode([Quote].self, from: data)
                print(quote)
            } catch let error {
                print(error.localizedDescription)
            }
            
            
        }.resume()
    }
    
    
}
