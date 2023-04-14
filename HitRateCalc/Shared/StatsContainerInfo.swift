//
//  StatsContainerInfo.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import Foundation

enum StatsContainerInfo {
    case evasion(Vision)
    case accuracy(Vision)
}

extension StatsContainerInfo: Identifiable {
    var id: String {
        switch self {
        case .evasion(let vision): return vision.id.uuidString
        case .accuracy(let vision): return vision.id.uuidString
            
        }
    }

    var title: String {
        switch self {
        case .evasion: return "Evasion"
        case .accuracy: return "Accuracy"
        }
    }
    
    var statList: [VisionStat] {
        switch self {
        case .evasion(let vision): return vision.evadeStats
        case .accuracy(let vision): return vision.accuracyStats
        }
    }
    
    var statRate: Int {
        switch self {
        case .evasion(let vision):
            return HitRateCalculator.getEvasionRate(for: vision)
        case .accuracy(let vision):
            return HitRateCalculator.getAccuracyRate(for: vision)
        }
    }
}
