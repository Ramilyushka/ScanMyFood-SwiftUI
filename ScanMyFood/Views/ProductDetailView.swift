//
//  ProductDetailView.swift
//  ScanMyFood
//
//  Created by Ramilia on 27/10/25.
//
import SwiftUI

struct ProductDetailView: View {
    typealias NutriKey = Nutriments.CodingKeys
    
    let barcode: String
    @StateObject private var viewModel = ProductDetailViewModel()
    
    var body: some View {
        ScrollView {
            switch viewModel.state {
            case .initial, .loading:
                ProgressView("Загрузка...")
                    .padding(.top, 50)
            case .data(let product):
                VStack(spacing: 20) {
                    AsyncImage(url: URL(string: product.imageURL ?? "")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 150)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 180)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text(product.productName ?? "Без названия")
                            .font(.title2.bold())
                        Text("Штрихкод: \(product.code ?? "-")")
                            .foregroundColor(.secondary)
                        Text("Бренд: \(product.brands ?? "-")")
                            .foregroundColor(.secondary)
                        Text("Состав: \(product.ingredientsText ?? "-")")
                            .foregroundColor(.secondary)
                    }

                    if let nutr = product.nutriments {
                        Divider()
                        Text("Пищевая ценность (на 100г):")
                            .font(.headline)
                            .padding(.bottom, 4)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            NutrimentRow(key: NutriKey.energyKcal, value: nutr.energyKcal)
                            NutrimentRow(key: NutriKey.proteins, value: nutr.proteins)
                            NutrimentRow(key: NutriKey.fat, value: nutr.fat)
                            NutrimentRow(key: NutriKey.saturatedFat, value: nutr.saturatedFat)
                            NutrimentRow(key: NutriKey.carbohydrates, value: nutr.carbohydrates)
                            NutrimentRow(key: NutriKey.sugars, value: nutr.sugars)
                            NutrimentRow(key: NutriKey.salt, value: nutr.salt)
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                }
                .padding()
                
            case .failed(let error):
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear {
            viewModel.getProduct(with: barcode)
        }
        .navigationTitle("О продукте")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}
