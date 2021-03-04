//
//  DetailRecipeVC.swift
//  Cooky
//
//  Created by Oleg Krikun on 04.03.2021.
//

import UIKit

class DetailRecipeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dishImageView: RecipeImageView! {
        didSet {
            dishImageView.layer.cornerRadius = 7
        }
    }

    @IBOutlet weak var caloriesOfDishLabel: UILabel!
    @IBOutlet weak var dailyValueLabel: UILabel!
    @IBOutlet weak var numberOfServingsLabel: UILabel!
    
    @IBOutlet weak var numberOfIngredientsLabel: UILabel!
    @IBOutlet weak var ingredientTableView: UITableView!
    
    @IBOutlet weak var nutritionTableView: UITableView!
    
    var recipe: Recipe?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientTableView.delegate = self
        nutritionTableView.delegate = self
        ingredientTableView.dataSource = self
        nutritionTableView.dataSource = self
        
        setupUI()
    }
    
    @IBAction func openWebsiteButton(_ sender: UIButton) {
        if let url = URL(string: recipe?.shareAs ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        switch tableView {
        case ingredientTableView: numberOfRows = recipe?.ingredients?.count ?? 0
        case nutritionTableView: numberOfRows = recipe?.totalNutrients?.count ?? 0
        default: print("Some things Wrong!!")
        }
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch tableView {
        case ingredientTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
            cell.textLabel?.text = recipe?.ingredients?[indexPath.row].text
            cell.backgroundColor = .black
            cell.textLabel?.textColor = .orange
        case nutritionTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: "nutritionCell", for: indexPath)
            cell.textLabel?.text = nutrientForRecipe(index: indexPath.row)
            cell.backgroundColor = .black
            cell.textLabel?.textColor = .orange
        default: print("Some things Wrong!!")
        }
        return cell
    }
    
    private func setupUI() {
        navigationItem.title = recipe?.label
        
        dishImageView.fetchImageRecipe(from: recipe?.image ?? "")
        
        caloriesOfDishLabel.text = String(lround(recipe?.calories ?? 0))
        dailyValueLabel.text = totalDaily()
        numberOfServingsLabel.text = String(recipe?.yield ?? 0)
        numberOfIngredientsLabel.text = String(recipe?.ingredients?.count ?? 0) + " Ingredients"
        
        caloriesOfDishLabel.textColor = .orange
        dailyValueLabel.textColor = .orange
        numberOfServingsLabel.textColor = .orange
        
        ingredientTableView.backgroundColor = .black
        nutritionTableView.backgroundColor = .black
    }
    
    private func totalDaily() -> String {
        guard let totalDailys = recipe?.totalDaily else { return "0" }
        var energyDaily: String?
        for i in totalDailys {
            if i.key == "ENERC_KCAL" {
                let energyDish = i.value.quantity ?? 0.0
                let yieldDish = Double(recipe?.yield ?? 1)
                let energyServing = energyDish / yieldDish
                energyDaily = String(lround(energyServing)) + "%"
            }
        }
        
        return energyDaily ?? "0"
    }
    
    private func nutrientForRecipe(index: Int) -> String {
        guard let totalNutrients = recipe?.totalNutrients else { return "0" }
        let nutrients = totalNutrients.sorted { (arg0, arg1) -> Bool in
            arg0.key < arg1.key
        }
        let label = nutrients[index].value.label ?? ""
        let quantity = String(lround(nutrients[index].value.quantity ?? 0))
        let unit = nutrients[index].value.unit?.rawValue ?? ""
        let recipeNutrient = label + " " + quantity + " " + unit
        return recipeNutrient
    }

}
