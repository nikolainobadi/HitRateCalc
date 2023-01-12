//
//  HitRateCalculator.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 1/12/23.
//

import Foundation

enum HitRateCalculator {
    static func getEvasionRate(agility: Double, luck: Double, bonus: Double) -> Int {
        return makeRoundedInt(getBaseRate(luck: getLuckValue(luck), otherTrait: getAgilityValue(agility)) + bonus)
    }
    
    static func getAccuracyRate(dex: Double, luck: Double, bonus: Double) -> Int {
        return makeRoundedInt(getBaseRate(luck: getLuckValue(luck), otherTrait: getDexterityValue(dex)) + bonus)
    }
    
    static func getHitRate(accuracyRate: Int, evasionRate: Int) -> Int {
        return makeRoundedInt(Double(accuracyRate) - Double(evasionRate))
    }
    
    static func getChanceToEvade(evasionRate: Int, accuracyRate: Int) -> Int {
        return 100 - getHitRate(accuracyRate: accuracyRate, evasionRate: evasionRate)
    }
}


// MARK: - Private
private extension HitRateCalculator {
    static func makeRoundedInt(_ num: Double) -> Int { Int(round(num)) }
    static func getLuckValue(_ luck: Double) -> Double { pow(luck, 0.96) / 200 - 1 }
    static func getDexterityValue(_ dex: Double) -> Double { (11 * pow(dex, 0.2)) / 20 }
    static func getAgilityValue(_ agility: Double) -> Double { (11 * pow(agility, 0.9)) / 1000 }
    static func getBaseRate(luck: Double, otherTrait: Double) -> Double { (luck + otherTrait) * 100 }
}
