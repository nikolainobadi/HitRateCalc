//
//  SharedCoreDataManager.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import SwiftUI
import CoreData

final class SharedCoreDataManager {
    static let shared = SharedCoreDataManager()
    private let container: NSPersistentContainer
    private let dataModelName = "HitRateCalcCoreDataModel"
    
    private init() {
        container = NSPersistentContainer(name: dataModelName)
        if EnvironmentValues.isPreview {
            container.persistentStoreDescriptions.first?.url = .init(URL(fileURLWithPath: "/dev/null"))
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("no data means no app, error: \(error.localizedDescription)")
            }
        }
    }
}


// MARK: - ViewContext
extension SharedCoreDataManager {
    var viewContext: NSManagedObjectContext { container.viewContext }
}


// MARK: - Store
extension SharedCoreDataManager: VisionStore {
    func saveVision(_ vision: Vision) async throws {
        if let existingEntity = getVisionEntity(vision) {
            updateExistingEntity(entity: existingEntity, newData: vision)
        } else {
            addNewVision(vision)
        }
        
        try await viewContext.perform { [unowned self] in
            try viewContext.save()
        }
    }
}


// MARK: - Private Methods
private extension SharedCoreDataManager {
    func getVisionEntity(_ vision: Vision) -> VisionEntity? {
        let request: NSFetchRequest<VisionEntity>
        request = VisionEntity.all()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "id == %@", vision.id as CVarArg)
        
        guard let result = try? container.viewContext.fetch(request).first else {
            return nil
        }
        
        return result
    }
    
    func updateExistingEntity(entity: VisionEntity, newData: Vision) {
        entity.name = newData.name
        entity.luck = newData.luck.toInt16
        entity.agility = newData.agility.toInt16
        entity.dexterity = newData.dexterity.toInt16
        entity.evasion = newData.evasion.toInt16
        entity.accuracy = newData.accuracy.toInt16
    }
    
    func addNewVision(_ vision: Vision) {
        let newEntity = VisionEntity(context: viewContext)
        newEntity.id = vision.id
        
        updateExistingEntity(entity: newEntity, newData: vision)
    }
}


// MARK: - Dependencies
extension EnvironmentValues {
    static var isPreview: Bool { ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" }
}

extension Int {
    var toInt16: Int16 { Int16(self) }
}

extension Int16 {
    var toInt: Int { Int(self) }
}
