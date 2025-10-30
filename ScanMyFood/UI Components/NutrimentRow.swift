//
//  NutrimentRow.swift
//  ScanMyFood
//
//  Created by Ramilia on 30/10/25.
//
import SwiftUI

struct NutrimentRow: View {
    let key: Nutriments.CodingKeys
    let value: Double?
    let unknownValue: String = "-"

    var body: some View {
        HStack {
            Text(key.label)
            Spacer()
            if let value {
                Text(String(format: "%.1f %@", value, key.unit))
                    .foregroundColor(.secondary)
            } else {
                Text(unknownValue)
                    .foregroundColor(.secondary)
            }
        }
        .font(.subheadline)
    }
}
