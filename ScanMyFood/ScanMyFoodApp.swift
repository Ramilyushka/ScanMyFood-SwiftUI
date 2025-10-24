//
//  ScanMyFoodApp.swift
//  ScanMyFood
//
//  Created by Наиль on 24/10/25.
//

import SwiftUI
import CoreData

@main
struct ScanMyFoodApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
