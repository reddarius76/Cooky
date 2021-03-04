//
//  Ingredient.swift
//  Cooky
//
//  Created by Oleg Krikun on 28.02.2021.
//

struct IngredientTest {
    let id: Int
    let name: String
}

extension IngredientTest {
    static func generationIngredients() -> [IngredientTest] {
        var ingredients = [IngredientTest]()
        
        for x in 0..<IngredientsDataManager.shared.ids.count {
            for y in 0..<IngredientsDataManager.shared.names[x].count {
                ingredients.append(
                    IngredientTest(
                        id: IngredientsDataManager.shared.ids[x],
                        name: IngredientsDataManager.shared.names[x][y]
                    )
                )
            }
        }
    return ingredients
    }
    
    static func getIngredientsFor(recipeId: Int) -> [IngredientTest] {
        let ingredientsAll = generationIngredients()
        let ingredients = ingredientsAll.filter { Ingredient -> Bool in
            Ingredient.id == recipeId
        }
        
    return ingredients
    }
}
