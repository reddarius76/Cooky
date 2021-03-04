//
//  Recipe.swift
//  Cooky
//
//  Created by Oleg Krikun on 28.02.2021.
//

struct RecipeTest {
    let id: Int
    let name: String
    let image: String
    var ingredientsId: Int
    var ingredients: Array<IngredientTest>
    let calories: Double
    let yield: Double
}

extension RecipeTest {
    static func generationRecipes() -> [RecipeTest] {
        var recipes = [RecipeTest]()
        
        for i in 0..<RecipesDataManager.shared.ids.count {
            recipes.append(
                RecipeTest(
                    id: RecipesDataManager.shared.ids[i],
                    name: RecipesDataManager.shared.names[i],
                    image: RecipesDataManager.shared.images[i],
                    ingredientsId: RecipesDataManager.shared.ingredientsIds[i],
                    ingredients: IngredientTest.getIngredientsFor(recipeId: i),
                    calories: RecipesDataManager.shared.calories[i],
                    yield: RecipesDataManager.shared.yields[i])
            )
        }
    return recipes
    }
}
