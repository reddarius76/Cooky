//
//  RecipeImageView.swift
//  Cooky
//
//  Created by Oleg Krikun on 03.03.2021.
//

import UIKit

class RecipeImageView: UIImageView {

    //MARK: - fetchImageRecipe()
    func fetchImageRecipe(from urlString: String) {
        guard let imageURL = URL(string: urlString) else {
            image = UIImage(systemName: "text.justify")?.withTintColor(.orange, renderingMode: .alwaysOriginal)
            return
        }
        
        if let cachedImage = getCacheImage(from: imageURL) {
            image = cachedImage
            return
        }
        
        NetworkManager.shared.request(urlString: urlString) { [unowned self] (data, response, error) in
            guard let url = URL(string: urlString) else { return }
            guard url == response?.url else { return }
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "Didn't receive the image over the network")
                return
            }
            DispatchQueue.main.async {
                image = UIImage(data: data)
            }
            saveDataToCache(with: data, and: response)
        }
    }
    
    //MARK: - private func
    //MARK: - getCacheImage()
    private func getCacheImage(from url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
    
    //MARK: - saveDataToCache()
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let urlRequest = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
}
