//
//  ProductInfoNetwork.swift
//  ScanMyFood-UIKit
//
//  Created by Ramilia on 25/10/25.
//
import Foundation

typealias ProductCompletion = (Result<ProductResponse, Error>) -> Void

protocol ProductNetworkProtocol {
    func getProduct(with barcode: String, completion: @escaping ProductCompletion)
}

final class ProductNetwork: ProductNetworkProtocol {

    private let networkClient: NetworkClient = DefaultNetworkClient()

    func getProduct(with barcode: String, completion: @escaping ProductCompletion) {

        let request = ProductRequest(barcode: barcode)
        
        networkClient.send(request: request, type: ProductResponse.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
