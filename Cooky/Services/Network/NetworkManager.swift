//
//  NetworkingManager.swift
//  Cooky
//
//  Created by Oleg Krikun on 03.03.2021.
//

import Foundation

protocol Networking {
    func request(urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

class NetworkManager: Networking {
    static let shared = NetworkManager()
    
    // Request data by url
    func request(urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid urlString for the request!")
            return }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }
    }
    
    private init() {}
}
