//
//  ProductInfoRequest.swift
//  ScanMyFood-UIKit
//
//  Created by Ramilia on 25/10/25.
//
import Foundation

enum RequestConstants {
    static let baseURL = "https://world.openfoodfacts.org"
}

struct ProductRequest: NetworkRequest {
    let barcode: String
    var httpMethod: HttpMethod { .get }
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v0/product/\(barcode).json")
    }
}
