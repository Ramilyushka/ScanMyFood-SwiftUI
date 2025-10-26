//
//  ProductDetailViewModel.swift
//  ScanMyFood
//
//  Created by Ramilia on 27/10/25.
//
import SwiftUI
import Combine

final class ProductDetailViewModel: ObservableObject {
    
    @Published var state: State = .initial
    
    private let networkService: ProductNetworkProtocol
    
    init(networkService: ProductNetworkProtocol = ProductNetwork()) {
        self.networkService = networkService
    }

    func getProduct(with barcode: String) {
        state = .loading
        networkService.getProduct(with: barcode) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if let product = response.product {
                        self.state = .data(product)
                        //self.coreDataManager.saveProduct(product)
                    } else {
                        self.state = .failed("Нет продукта")
                    }
                    
                case .failure(let error):
                    self.state = .failed(error.localizedDescription)
                }
            }
        }
    }
}

extension ProductDetailViewModel {
    enum State {
        case initial
        case loading
        case data(Product)
        case failed(String)
    }
}
