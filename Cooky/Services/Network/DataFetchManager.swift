//
//  DataFetchManager.swift
//  Cooky
//
//  Created by Oleg Krikun on 18.03.2021.
//

import Foundation

class DataFetchManager {
    var dataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = NetworkDataFetch()) {
        self.dataFetcher = dataFetcher
    }
    
    func fetchRecipe(urlString: String, completion: @escaping (Edamam?) -> Void) {
        dataFetcher.fetchGenericJSONData(urlString: urlString, completion: completion)
    }
}
