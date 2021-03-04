//
//  Edamam.swift
//  Cooky
//
//  Created by Oleg Krikun on 28.02.2021.
//

import Foundation

// MARK: - Edamam
struct Edamam: Decodable {
    let q: String?
    let from: Int?
    let to: Int?
    let more: Bool?
    let count: Int?
    let hits: [Hit]?
}

// MARK: - Hit
struct Hit: Decodable {
    let recipe: Recipe?
    let bookmarked: Bool?
    let bought: Bool?
}

// MARK: - Recipe
struct Recipe: Decodable {
    let uri: String?
    let label: String?
    let image: String?
    let source: String?
    let url: String?
    let shareAs: String?
    let yield: Int?
    let dietLabels: [String]?
    let healthLabels: [String]?
    let cautions: [String]?
    let ingredientLines: [String]?
    let ingredients: [Ingredient]?
    let calories: Double?
    let totalWeight: Double?
    let totalTime: Int?
    let totalNutrients: [String: Total]?
    let totalDaily: [String: Total]?
    let digest: [Digest]?
}

// MARK: - Digest
struct Digest: Decodable {
    let label: String?
    let tag: String?
    let schemaOrgTag: String?
    let total: Double?
    let hasRdi: Bool?
    let daily: Double?
    let unit: Unit?
    let sub: [Digest]?
}

enum Unit: String, Decodable {
    case empty = "%"
    case g = "g"
    case kcal = "kcal"
    case mg = "mg"
    case µg = "µg"
}

// MARK: - Ingredient
struct Ingredient: Decodable {
    let text: String?
    let weight: Double?
    let image: String?
}

// MARK: - Total
struct Total: Decodable {
    let label: String?
    let quantity: Double?
    let unit: Unit?
}
