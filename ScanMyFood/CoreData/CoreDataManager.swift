//
//  CoreDataManager.swift
//  ScanMyFood-UIKit
//
//  Created by Ramilia on 26/10/25.
//
import CoreData

final class CoreDataManager {
    private let container: NSPersistentContainer
    
    init(modelName: String = "ScanMyFood") {
        container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Ошибка загрузки Core Data: \(error.localizedDescription)")
            }
        }
    }
    
    private var context: NSManagedObjectContext {
        container.viewContext
    }

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Ошибка при сохранении контекста: \(error.localizedDescription)")
            }
        }
    }
}

extension CoreDataManager {
    private func isProductAlreadySaved(code: String) -> Bool {
        let request: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        request.predicate = NSPredicate(format: "code == %@", code)

        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Ошибка при проверке существования продукта: \(error)")
            return false
        }
    }

    func saveProduct(_ product: Product) {
        guard let code = product.code, !isProductAlreadySaved(code: code) else {
            print("Продукт уже сохранeн")
            return
        }

        let entity = ProductEntity(context: context)
        entity.code = code
        entity.name = product.productName
        entity.date = Date()

        saveContext()
        print("Продукт сохранeн: \(product.productName ?? "Без названия")")
    }

    func fetchAllProducts() -> [ProductEntity] {
        let request: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]
        
        do {
            return try context.fetch(request)
        } catch {
            print("Ошибка при получении продуктов: \(error)")
            return []
        }
    }
}
