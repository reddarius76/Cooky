//
//  DataManager.swift
//  Cooky
//
//  Created by Oleg Krikun on 28.02.2021.
//

class RecipesDataManager {
    
    static let shared = RecipesDataManager()
    
    let ids = [0, 1, 2]
    let names = [
        "Brummie bacon cakes",
        "Cobb Salad with Warm Bacon Vinaigrette",
        "Corn Brulee With Spicy Candied Bacon & Tomato Sorbet"
    ]
    let images = [
        "https://www.edamam.com/web-img/698/6985effb95edb884785f712dca2acd15.jpg",
        "https://www.edamam.com/web-img/c9a/c9af5581d1b4cc4673514d46bc3281fc.jpg",
        "https://www.edamam.com/web-img/494/494f8971d9a6831476e2b0f7b28bdb54.jpg"
    ]
    let ingredientsIds = [0, 1, 2]
    let calories = [1797.61, 517.55, 1589.58]
    let yields = [4.0, 8.0, 4.0]
    
    private init() {}
}

class IngredientsDataManager {
    
    static let shared = IngredientsDataManager()
    
    let ids = [0, 1, 2]
    let names = [
        [
        "3 Rashers streaky bacon (we used smoked)",
        "225g Self-raising flour, plus extra for dusting",
        "25g Butter, cold and cut into small pieces",
        "75g Mature cheddar, grated",
        "150ml Milk, plus 2 tbsp extra for glazing",
        "1 tbsp Tomato ketchup",
        "½ tsp Worcestershire sauce"
        ],
        [
        "1 heart of romaine, torn into bite-size pieces",
        "3 cups packed baby spinach",
        "4 bacon slices, chopped",
        "1 tablespoon vegetable oil",
        "6 chicken tenders (about 1/2 pound)",
        "2 tablespoons red-wine vinegar",
        "1 1/2 tablespoons cider vinegar",
        "1 teaspoon grainy mustard",
        "2 hard-boiled eggs, halved",
        "1 small tomato, cut into wedges",
        "1/2 avocado",
        "1/2 cup crumbled blue cheese (3 ounces)"
        ],
        [
        "1.5 lb very ripe tomatoes",
        "1.5 c water",
        "0.5 c corn syrup",
        "0.25 t smoked paprika",
        "1 T non-fat milk powder (optional to improve texture)",
        "6 sli extra thick bacon",
        "0.5 c light brown sugar, packed",
        "0.25 t cayenne pepper",
        "2 c heavy cream",
        "2 ears corn, kernels removed cob saved",
        "2 T sugar",
        "5 large egg yolks, at room temperature"
        ]
    ]
    
    private init() {}
}
