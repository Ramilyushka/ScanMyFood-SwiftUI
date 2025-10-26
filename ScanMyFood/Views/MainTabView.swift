//
//  Untitled.swift
//  ScanMyFood
//
//  Created by Ramilia on 27/10/25.
//
import SwiftUI

struct MainTabView: View {
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView {
            NavigationStack {
                ScannerView()
            }
            .tabItem {
                Label("Сканировать", systemImage: "barcode.viewfinder")
            }
            
            NavigationStack {
                // HistoryView()
            }
            .tabItem {
                Label("История", systemImage: "list.dash.header.rectangle")
            }
        }
    }
}
