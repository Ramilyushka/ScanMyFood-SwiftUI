//
//  HistoryViewModel.swift
//  ScanMyFood
//
//  Created by Ramilia on 27/10/25.
//
import SwiftUI
import Combine

final class HistoryViewModel: ObservableObject {
    private let coreDataManager = CoreDataManager()
    @Published var products: [ProductEntity] = []
    
    func getSavedProducts() {
        products = coreDataManager.fetchAllProducts()
    }
}
