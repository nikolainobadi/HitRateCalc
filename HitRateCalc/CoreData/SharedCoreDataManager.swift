//
//  SharedCoreDataManager.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import CoreData

final class SharedCoreDataManager {
    static let shared = SharedCoreDataManager()
    private let container: NSPersistentContainer
    private let dataModelName = "HitRateCalcCoreDataModel"
    
    private init() {
        container = NSPersistentContainer(name: dataModelName)
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("no data means no app, error: \(error.localizedDescription)")
            }
        }
    }
}
