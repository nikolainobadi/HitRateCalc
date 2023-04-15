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
    var finalRate: String { String(checkingHitRate ? hitRate : (100 - hitRate)) }
    var finalRateTitle: String {
        if checkingHitRate {
            return "Chance for \(attackerName) to hit \(defenderName)"
        } else {
            return "Chance for \(defenderName) to evade \(attackerName)"
        }
    }
    
    func resetAttacker() { attacker = Vision() }
    func resetDefender() { defender = Vision() }
    func editAttacker() { selectedInfo = .accuracy(attacker) }
    func editDefender() { selectedInfo = .evasion(defender) }
    func getVisionToReplace(info: StatsContainerInfo) -> Binding<Vision> {
        Binding<Vision> {
            switch info {
            case .evasion: return self.defender
            case .accuracy: return self.attacker
            }
        } set: { newValue in
            switch info {
            case .evasion: self.defender = newValue
            case .accuracy: self.attacker = newValue
            }
        }
    }
}


// MARK: - Private
private extension HitRateDataModel {
    var attackerName: String { attacker.name.isEmpty ? "attacker" : "'\(attacker.name)'" }
    var defenderName: String { defender.name.isEmpty ? "enemy unit" : "'\(defender.name)'" }
    var hitRate: Int { HitRateCalculator.getHitRate(attacker: attacker, defender: defender) }
}
