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
    func saveVision(_ vision: Vision) throws {
        guard viewContext.hasChanges else { return }
        
//        try viewContext.save()
    }
}


// MARK: - Dependencies
extension EnvironmentValues {
    static var isPreview: Bool { ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" }
}
