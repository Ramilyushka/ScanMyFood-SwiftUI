//
//  HistoryView.swift
//  ScanMyFood
//
//  Created by Ramilia on 27/10/25.
//
import SwiftUI

struct HistoryView: View {
    @StateObject var viewModel: HistoryViewModel = HistoryViewModel()

    var body: some View {
        List {
            ForEach(viewModel.products) { product in
                NavigationLink(destination: ProductDetailView(barcode: product.code ?? "")) {
                    VStack(alignment: .leading) {
                        Text(product.name ?? "Без названия")
                            .font(.headline)
                        Text("Штрихкод: \(product.code ?? "-")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        if let date = product.date {
                            Text(date.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.getSavedProducts()
        }
        .navigationTitle("История")
    }
}
