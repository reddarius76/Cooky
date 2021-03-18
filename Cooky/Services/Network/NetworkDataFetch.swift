//
//  NetworkDataFetch.swift
//  Cooky
//
//  Created by Oleg Krikun on 18.03.2021.
//

import Foundation

protocol DataFetcher {
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?) -> Void)
}

class NetworkDataFetch: DataFetcher {
    
    // Decode the received JSON in the model
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?) -> Void) {
        NetworkManager.shared.request(urlString: urlString) { [unowned self] (data, response, error)  in
            guard let url = URL(string: urlString) else { return }
            guard url == response?.url else { return }
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            let resultDecoded = decodeJSON(type: T.self, data: data)
            completion(resultDecoded)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, data: Data?) -> T? {
        guard let data = data else { return nil }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch let jsonDecoderError {
            print("Failed to decode JSON: \(jsonDecoderError.localizedDescription)")
            return nil
        }
    }
 }
