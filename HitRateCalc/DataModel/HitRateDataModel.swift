//
//  HitRateDataModel.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import SwiftUI
import Foundation

final class HitRateDataModel: ObservableObject {
    @Published var attacker = Vision()
    @Published var defender = Vision()
    @Published var checkingHitRate = true
    @Published var selectedInfo: StatsContainerInfo?
}


// MARK: - ViewModel
extension HitRateDataModel {
    var finalRateTitle: String { "Chance to \(checkingHitRate ? "hit" : "evade") enemy unit" }
    var finalRate: String { String(checkingHitRate ? hitRate : (100 - hitRate)) }
    
    func resetAttacker() { attacker = Vision() }
    func resetDefender() { defender = Vision() }
    func editAttacker() { selectedInfo = .accuracy(attacker) }
    func editDefender() { selectedInfo = .evasion(defender) }
    func getVisionToReplace(id: UUID) -> Binding<Vision> {
        Binding<Vision> {
            if self.attacker.id == id { return self.attacker }
            if self.defender.id == id { return self.defender }
            
            fatalError("should not occur")
        } set: { newValue in
            if self.attacker.id == id { self.attacker = newValue }
            if self.defender.id == id { self.defender = newValue }
            
            fatalError("should not occur")
        }
    }
}


// MARK: - Private
private extension HitRateDataModel {
    var hitRate: Int { HitRateCalculator.getHitRate(attacker: attacker, defender: defender) }
}
