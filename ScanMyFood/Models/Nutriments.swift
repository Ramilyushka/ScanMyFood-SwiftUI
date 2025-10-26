//
//  Nutriments.swift
//  ScanMyFood
//
//  Created by Ramilia on 27/10/25.
//
import Foundation

struct Nutriments: Codable {
    let energyKcal: Double?
    let fat: Double?
    let saturatedFat: Double?
    let carbohydrates: Double?
    let sugars: Double?
    let fiber: Double?
    let proteins: Double?
    let salt: Double?

    enum CodingKeys: String, CodingKey {
        case energyKcal = "energy-kcal"
        case fat
        case saturatedFat = "saturated-fat"
        case carbohydrates
        case sugars
        case fiber
        case proteins
        case salt
    }
}

struct NutrimentItem {
    let name: String
    let value: String
}

extension Nutriments {
    func asArray() -> [NutrimentItem] {
        [
            NutrimentItem(name: "Энергия", value: formatted(energyKcal, suffix: "ккал")),
            NutrimentItem(name: "Жиры", value: formatted(fat, suffix: "г")),
            NutrimentItem(name: "Насыщенные жиры", value: formatted(saturatedFat, suffix: "г")),
            NutrimentItem(name: "Углеводы", value: formatted(carbohydrates, suffix: "г")),
            NutrimentItem(name: "Сахара", value: formatted(sugars, suffix: "г")),
            NutrimentItem(name: "Клетчатка", value: formatted(fiber, suffix: "г")),
            NutrimentItem(name: "Белки", value: formatted(proteins, suffix: "г")),
            NutrimentItem(name: "Соль", value: formatted(salt, suffix: "г"))
        ].filter { !$0.value.isEmpty }
    }

    private func formatted(_ value: Double?, suffix: String) -> String {
        guard let value = value else { return "" }
        return String(format: "%.1f %@", value, suffix)
    }
}
