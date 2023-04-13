//
//  HitRateDataModel.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import Foundation

final class HitRateDataModel: ObservableObject {
    @Published var attacker = Vision()
    @Published var defender = Vision()
    @Published var checkingHitRate = true
}


// MARK: - ViewModel
extension HitRateDataModel {
    var finalRateTitle: String { "Chance to \(checkingHitRate ? "hit" : "evade") enemy unit" }
    var finalRate: String { String(checkingHitRate ? hitRate : (100 - hitRate)) }
    
    func resetAttacker() { attacker = Vision() }
    func resetDefender() { defender = Vision() }
}


// MARK: - Private
private extension HitRateDataModel {
    var hitRate: Int { HitRateCalculator.getHitRate(attacker: attacker, defender: defender) }
}
