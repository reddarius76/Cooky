//
//  MainCVController.swift
//  Cooky
//
//  Created by Oleg Krikun on 28.02.2021.
//

import UIKit

class RecipeCollectionViewController: UICollectionViewController {
    
    private var recipes = [Hit]()
    private let dataFetchManager = DataFetchManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateRecipe(ingredients: "salmon")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        let index = indexPath.row
        guard let detailRecipeVC = segue.destination as? DetailRecipeViewController else { return }
        detailRecipeVC.recipe = recipes[index].recipe
    }
    
    private func setupUI() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .black
        setupSearchController()
    }
    
    private func updateRecipe(ingredients: String) {
        let urlRecipe = APIConfigEdamam.shared.url + "&q=\(ingredients)"
        dataFetchManager.fetchRecipe(urlString: urlRecipe) { [unowned self] (edamam) in
            guard let recipe = edamam?.hits else { return }
            recipes.removeAll()
            recipes.append(contentsOf: recipe)
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension RecipeCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipe", for: indexPath) as! RecipeCell
        let recipe = recipes[indexPath.row]
        
        cell.configureCell(with: recipe.recipe!)
        return cell
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

//MARK: - UISearchResults
extension RecipeCollectionViewController: UISearchBarDelegate {
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "What foods do you want to use in dish?"
        searchController.searchBar.tintColor = .orange
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
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
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        if text == "" {
            searchBar.setShowsCancelButton(false, animated: false)
            return
        }
        let ingredients = text.replacingOccurrences(of: " ", with: "")
        searchBar.setShowsCancelButton(false, animated: false)
        updateRecipe(ingredients: ingredients)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: false)
    }
}

