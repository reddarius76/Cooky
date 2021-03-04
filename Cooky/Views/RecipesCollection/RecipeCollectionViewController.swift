//
//  MainCVController.swift
//  Cooky
//
//  Created by Oleg Krikun on 28.02.2021.
//

import UIKit

class RecipeCollectionViewController: UICollectionViewController {
    
    private var recipes = [Hit]()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        URLCache.shared.diskCapacity = 52428800
        //URLCache.shared.removeAllCachedResponses()
        
        let ingredients = "banana,icecream"
        NetworkManager.shared.getRecipe(with: ingredients) { [unowned self] edamam in
            guard let recipe = edamam.hits else { return }
            recipes.append(contentsOf: recipe)
            collectionView.reloadData()
        }
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .black
        setupSearchController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        let index = indexPath.row
        let detailRecipeVC = segue.destination as! DetailRecipeVC
        detailRecipeVC.recipe = recipes[index].recipe
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipe", for: indexPath) as! RecipeCell
        let recipe = recipes[indexPath.row]
        
        cell.configureCell(with: recipe.recipe!)
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

//MARK: - UISearchResults
extension RecipeCollectionViewController: UISearchResultsUpdating {
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "What foods do you want to use in dish?"
        searchController.searchBar.tintColor = .orange
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = false
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 14)
            textField.textColor = .white
            textField.leftView?.tintColor = .orange
            if let button = textField.value(forKey: "clearButton") as? UIButton {
                button.setImage(UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
                button.tintColor = UIColor.orange.withAlphaComponent(0.7)
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
//        searchName = searchController.searchBar.text
//        filterCharacterForSearchText(searchName!)
    }
    
    private func clearSearch() {
//        countPagesSearch = nil
//        currentPageSearch = 1
//        cellStepSearch = 20
//        charactersSearch.removeAll()
//        dataTasksSearch.removeAll()
//        tableView.reloadData()
    }
    
    private func filterCharacterForSearchText(_ searchText: String) {
        clearSearch()
        
//        if searchText == "" { return }
//
//        let dataTaskFromFirstPageSearch = NetworkManager.shared.fetchCharacter(url: urlAPI.urlCharacter.rawValue, page: currentPageSearch, name: searchText, dataTasks: dataTasksSearch) { [self] infoCharacter in
//
//            guard let results = infoCharacter?.results else { return }
//            countPagesSearch = infoCharacter?.info?.pages
//            charactersSearch.append(contentsOf: results)
//            currentPageSearch = currentPageSearch + 1
//            tableView.reloadData()
//        }
//        dataTasksSearch.append(dataTaskFromFirstPageSearch)
    }
}


//MARK: - UICollectionViewDelegateFlowLayout
extension RecipeCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCellInRow: CGFloat = 2
        let paddingWidth = 4 * (numberOfCellInRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthItem = availableWidth / numberOfCellInRow
        return CGSize(width: widthItem, height: widthItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}
