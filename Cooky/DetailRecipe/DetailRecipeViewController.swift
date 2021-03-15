//
//  DetailRecipeVC.swift
//  Cooky
//
//  Created by Oleg Krikun on 04.03.2021.
//

import UIKit

class DetailRecipeViewController: UIViewController {
    
    @IBOutlet weak var dishImageView: RecipeImageView!
    
    @IBOutlet weak var caloriesOfDishLabel: UILabel!
    @IBOutlet weak var dailyValueLabel: UILabel!
    @IBOutlet weak var numberOfServingsLabel: UILabel!
    
    @IBOutlet weak var numberOfIngredientsLabel: UILabel!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var ingredientTVHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nutritionTableView: UITableView!
    @IBOutlet weak var nutritionTVHeightConstraint: NSLayoutConstraint!
    
    
    var recipe: Recipe?
    private var sections = [Section]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientTableView.delegate = self
        nutritionTableView.delegate = self
        ingredientTableView.dataSource = self
        nutritionTableView.dataSource = self
        sections = calcSections()
        dishImageView.fetchImageRecipe(from: recipe?.image ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    private func getNutrition() -> [Digest?] {
        var digests = [Digest]()
        guard let digest = recipe?.digest else { return [nil] }
        digests.append(contentsOf: digest)
        return digests
    }
    
    private func calcSections() -> [Section] {
        let digests = getNutrition()
        var sections = [Section]()
        
        let d = digests.filter { digest -> Bool in
            digest?.sub != nil
        }
        
        d.forEach { digest in
            var a = [Digest]()
            digest?.sub?.forEach({ digest in
                a.append(digest)
            })
            sections.append(Section(name: digest?.label ?? "Not found", nutrition: a, expanded: false))
        }
        
        let c = digests.filter { digest -> Bool in
            digest?.sub == nil
        }
        
        sections.append(Section(name: "Extra", nutrition: c, expanded: false))

        return sections
    }

    @IBAction func openWebsiteButton(_ sender: UIButton) {
        if let url = URL(string: recipe?.shareAs ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    private func setupUI() {
        navigationItem.title = recipe?.label
    
        dishImageView.layer.cornerRadius = 7
        
        caloriesOfDishLabel.text = String(lround(recipe?.calories ?? 0))
        dailyValueLabel.text = totalDaily()
        numberOfServingsLabel.text = String(recipe?.yield ?? 0)
        numberOfIngredientsLabel.text = String(recipe?.ingredients?.count ?? 0) + " Ingredients"
        
        caloriesOfDishLabel.textColor = .orange
        dailyValueLabel.textColor = .orange
        numberOfServingsLabel.textColor = .orange
        
        ingredientTableView.backgroundColor = .black
        nutritionTableView.backgroundColor = .black
        ingredientTVHeightConstraint.constant = CGFloat(recipe?.ingredients?.count ?? 0) * 43.5
        nutritionTVHeightConstraint.constant = CGFloat(recipe?.totalNutrients?.count ?? 0) * 43.5
    }
    
    private func totalDaily() -> String {
        guard let totalDailys = recipe?.totalDaily else { return "0" }
        var energyDaily: String?
        for i in totalDailys {
            if i.key == "ENERC_KCAL" {
                let energyDish = i.value.quantity ?? 0.0
                let yieldDish = recipe?.yield ?? 1.0
                let energyServing = energyDish / yieldDish
                energyDaily = String(lround(energyServing)) + (i.value.unit ?? "")
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
        let unit = nutrients[index].value.unit ?? ""
        let recipeNutrient = label + " " + quantity + " " + unit
        
        return recipeNutrient
    }

}

extension DetailRecipeViewController: UITableViewDelegate, UITableViewDataSource, ExpandableHeadetViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        var numberOfSections = 0
        switch tableView {
        case ingredientTableView: numberOfSections = 1
        case nutritionTableView: numberOfSections = sections.count
        default: print("Some things Wrong")
        }
        
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        switch tableView {
        case ingredientTableView:
            numberOfRows = recipe?.ingredients?.count ?? 0
        case nutritionTableView:
            numberOfRows = sections[section].nutrition.count 
        default: print("Some things Wrong")
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
            let nameNutrition = sections[indexPath.section].nutrition[indexPath.row]?.label ?? ""
            let qty = String(format: "%.2f", sections[indexPath.section].nutrition[indexPath.row]?.daily ?? 0)
            let unit = sections[indexPath.section].nutrition[indexPath.row]?.unit ?? ""
            cell.textLabel?.text = "\(nameNutrition) \(qty)\(unit)"
            cell.backgroundColor = .black
            cell.textLabel?.textColor = .orange
        default: print("Some things Wrong")
        }
        return cell
    }
    
    //Collabseble section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var heightForHeaderInSection = 0
        switch tableView {
        case ingredientTableView: heightForHeaderInSection = 0
        case nutritionTableView: heightForHeaderInSection = 44
        default: print("Some things Wrong")
        }
    
        return CGFloat(heightForHeaderInSection)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var heightForRowAt = 0
        switch tableView {
        case ingredientTableView:
            heightForRowAt = 44
        case nutritionTableView:
            if sections[indexPath.section].expanded {
                heightForRowAt = 44
            }
        default: print("Some things Wrong")
        }
    
        return CGFloat(heightForRowAt)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        var heightForFooterInSection = 0
        switch tableView {
        case ingredientTableView:
            heightForFooterInSection = 0
        case nutritionTableView:
            heightForFooterInSection = 2
        default: print("Some things Wrong")
        }
    
        return CGFloat(heightForFooterInSection)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch tableView {
        case ingredientTableView: return nil
        case nutritionTableView:
            let header = ExpandableHeadetView()
            header.setup(withTitle: sections[section].name, section: section, delegate: self)
            return header
        default: print("Some things Wrong")
        }
        
        return nil
    }
    
    func toggleSection(header: ExpandableHeadetView, section: Int) {
        sections[section].expanded.toggle()
        
        nutritionTableView.beginUpdates()
        for row in 0..<sections[section].nutrition.count {
            nutritionTableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        }
        nutritionTableView.endUpdates()
    }
}

