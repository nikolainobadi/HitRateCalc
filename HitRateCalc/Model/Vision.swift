//
//  Vision.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import Foundation

struct Vision: Identifiable {
    var id: String = UUID().uuidString
    var name: String = ""
    var luck: Int = 0
    var agility: Int = 0
    var dexterity: Int = 0
    var evasion: Int = 0
    var accuracy: Int = 0
}


// MARK: - VisionStats
extension Vision {
    var evadeStats: [VisionStat] {
        [
            VisionStat(name: "Luck", amount: luck),
            VisionStat(name: "Agility", amount: agility),
            VisionStat(name: "Evade", amount: evasion)
        ]
    }
    
    var accuracyStats: [VisionStat] {
        [
            VisionStat(name: "Luck", amount: luck),
            VisionStat(name: "Dexterity", amount: dexterity),
            VisionStat(name: "Accuracy", amount: accuracy)
        ]
    }
}
