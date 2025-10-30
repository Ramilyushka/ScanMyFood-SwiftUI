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
    let proteins: Double?
    let salt: Double?
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case energyKcal = "energy-kcal"
        case fat
        case saturatedFat = "saturated-fat"
        case carbohydrates
        case sugars
        case proteins
        case salt
        
        var label: String {
            switch self {
            case .energyKcal:
                "Энергия"
            case .fat:
                "Жиры"
            case .saturatedFat:
                "Насыщенные жиры"
            case .carbohydrates:
                "Углеводы"
            case .sugars:
                "Сахара"
            case .proteins:
                "Белки"
            case .salt:
                "Соль"
            }
        }
        
        var unit: String {
            switch self {
            case .energyKcal:
                "ккал"
            case .fat, .saturatedFat, .carbohydrates, .sugars, .proteins, .salt:
                "г"
            }
        }
        
        func valueString(value: Double?) -> String {
            return self.label + ": " + (value.map(\.description) ?? "-") + " " + self.unit
        }
        
    }
}
