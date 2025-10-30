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
