//
//  NetworkManager.swift
//  BirdWatch
//
//  Created by Asen Ou on 11/19/25.
//

import Alamofire
import Foundation

class NetworkManager {

    /// Shared singleton instance
    static let shared = NetworkManager()

    private init() { }

    // MARK: - Requests

    /**
     Fetch the iOS birds!
     */
    func fetchBirds(completion: @escaping (Result<[Bird], Error>) -> Void) {
        let endpoint = "https://ios-course-backend.cornellappdev.com/api/members/bird-members"

        let decoder = JSONDecoder()

        // Create the request
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: [Bird].self, decoder: decoder) { response in
                // Handle the response
                switch response.result {
                case .success(let birds):
                    print("Successfully fetched \(birds.count) birds")
                    completion(.success(birds))
                case .failure(let error):
                    print("Error in NetworkManager.fetchBirds: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }
}
