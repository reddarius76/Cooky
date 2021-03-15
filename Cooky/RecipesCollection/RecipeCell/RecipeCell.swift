//
//  RecipeCell.swift
//  Cooky
//
//  Created by Oleg Krikun on 28.02.2021.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    
    @IBOutlet weak var imageRecipeImageView: RecipeImageView! {
        didSet {
            imageRecipeImageView.layer.cornerRadius = 7
        }
    }
    
    func configureCell(with result: Recipe) {
        let cellWidth = self.frame.width
        imageRecipeImageView.frame = CGRect(x: 0, y: 0, width: cellWidth, height: cellWidth)
        imageRecipeImageView.fetchImageRecipe(from: result.image ?? "")
    }
}
