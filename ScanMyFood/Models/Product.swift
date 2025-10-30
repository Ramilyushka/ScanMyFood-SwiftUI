//
//  Product.swift
//  ScanMyFood
//
//  Created by Ramilia on 27/10/25.
//

struct ProductResponse: Codable {
    let code: String
    let product: Product?
}

struct Product: Codable {
    let code: String?
    let productName: String?
    let brands: String?
    let imageURL: String?
    let ingredientsText: String?
    let nutriments: Nutriments?

    enum CodingKeys: String, CodingKey {
        case code
        case productName = "product_name"
        case brands
        case imageURL = "image_url"
        case ingredientsText = "ingredients_text"
        case nutriments
    }
}
