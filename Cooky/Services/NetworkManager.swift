//
//  NetworkingManager.swift
//  Cooky
//
//  Created by Oleg Krikun on 03.03.2021.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    //MARK: - getRecipe
    func getRecipe(with ingredients: String, excluded: String? = nil, completion: @escaping (Edamam) -> Void)  {
        
        
        let urlRecipe = APIConfigEdamam.shared.url + "&q=\(ingredients)" + "&excluded=grapefruit"
        
        guard let url = URL(string: urlRecipe) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "no localized description")
                return
            }
            
            guard url == response?.url else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let resultRecipe = try decoder.decode(Edamam.self, from: data)
                DispatchQueue.main.async {
                    completion(resultRecipe)
                }
            } catch let error {
                print("error JSONDecoder: \(error)")
            }
        }.resume()
    }
    
    //MARK: - fetchImage()
    func fetchImage(from url: URL, with completion: @escaping (Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "no localized description")
                return
            }
            guard url == response.url else { return }
            completion(data, response)
        }.resume()
    }
    
    private init(){}
}


