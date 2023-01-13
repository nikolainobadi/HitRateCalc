//
//  HitRateDataModel.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 1/12/23.
//

import Foundation

final class HitRateDataModel: ObservableObject {
    @Published var checkingHitRate: Bool
    @Published var evasionTraits: [Trait]
    @Published var accuracyTraits: [Trait]
    
    init(checkingHitRate: Bool = false, evasionTraits: [Trait] = Trait.evasionTraits, accuracyTraits: [Trait] = Trait.accuracyTraits) {
        self.checkingHitRate = checkingHitRate
        self.evasionTraits = evasionTraits
        self.accuracyTraits = accuracyTraits
    }
}


// MARK: - View Model
extension HitRateDataModel {
    var finalRate: String { checkingHitRate ? hitRate : chanceToEvade }
    var finalRateTitle: String { "Chance to \(checkingHitRate ? "hit" : "evade") enemy unit" }
    
    var evasionRate: Int {
        let evadeAmounts = evasionTraits.map({ $0.amount})
        
        return HitRateCalculator.getEvasionRate(agility: evadeAmounts[0], luck: evadeAmounts[1], bonus: evadeAmounts[2])
    }
    
    var accuracyRate: Int {
        let accAmounts = accuracyTraits.map({ $0.amount })
        
        return HitRateCalculator.getAccuracyRate(dex: accAmounts[0], luck: accAmounts[1], bonus: accAmounts[2])
    }
    
    func toggleMode() { checkingHitRate.toggle() }
    func clearValues(isEvasion: Bool) {
        if isEvasion {
            evasionTraits = evasionTraits.map({ Trait(id: $0.id, name: $0.name) })
        } else {
            accuracyTraits = accuracyTraits.map({ Trait(id: $0.id, name: $0.name) })
        }
    }
}


// MARK: - Private
private extension HitRateDataModel {
    var hitRate: String { "\(HitRateCalculator.getHitRate(accuracyRate: accuracyRate, evasionRate: evasionRate))" }
    var chanceToEvade: String { "\(HitRateCalculator.getChanceToEvade(evasionRate: evasionRate, accuracyRate: accuracyRate))" }
}
