//
//  ScanMyFoodApp.swift
//  ScanMyFood
//
//  Created by Ramilia on 24/10/25.
//

import SwiftUI
import CoreData

@main
struct ScanMyFoodApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
