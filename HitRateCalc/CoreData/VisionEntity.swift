//
//  VisionEntity.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/14/23.
//

import CoreData

final class VisionEntity: NSManagedObject {
    @NSManaged public var id: UUID?
    @NSManaged public var name: String
    @NSManaged public var luck: Int16
    @NSManaged public var agility: Int16
    @NSManaged public var dexterity: Int16
    @NSManaged public var evasion: Int16
    @NSManaged public var accuracy: Int16
}


// MARK: - Fetch
extension VisionEntity {
    static func all() -> NSFetchRequest<VisionEntity> {
        let request = NSFetchRequest<VisionEntity>(entityName: "VisionEntity")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \VisionEntity.name, ascending: true)]
        return request
    }
}

extension VisionEntity {
    @discardableResult
    static func makePreview(visionList: [Vision]) -> [VisionEntity] {
        visionList.map { vision in
            let entity = VisionEntity(context: SharedCoreDataManager.shared.viewContext)
            entity.id = vision.id
            entity.name = vision.name
            entity.luck = vision.luck.toInt16
            entity.agility = vision.agility.toInt16
            entity.dexterity = vision.dexterity.toInt16
            entity.evasion = vision.evasion.toInt16
            entity.accuracy = vision.accuracy.toInt16
            
            return entity
        }
    }
}
