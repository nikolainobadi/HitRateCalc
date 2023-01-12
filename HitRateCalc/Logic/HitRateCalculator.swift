//
//  HitRateCalculator.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 1/12/23.
//

import Foundation

enum HitRateCalculator {
    static func getEvasionRate(agility: String, luck: String, bonus: String) -> Int {
        let luckValue = getLuckValue(luck)
        let agilityValue = getAgilityValue(agility)
        let bonusValue = getBonusValue(bonus)
        let baseRate = getBaseRate(luck: luckValue, otherTrait: agilityValue)
        
        return makeRoundedInt(baseRate + bonusValue)
    }
    
    static func getAccuracyRate(dex: String, luck: String, bonus: String) -> Int {
        let luckValue = getLuckValue(luck)
        let dexValue = getDexterityValue(dex)
        let bonusValue = getBonusValue(bonus)
        let baseRate = getBaseRate(luck: luckValue, otherTrait: dexValue)
        
        return makeRoundedInt(baseRate + bonusValue)
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
    static func getBonusValue(_ other: String) -> Double { Double(other) ?? 0 }
    static func getBaseRate(luck: Double, otherTrait: Double) -> Double { (luck + otherTrait) * 100 }
    
    static func getLuckValue(_ luck: String) -> Double {
        guard let number = Double(luck) else { return 0 }
        
        return pow(number, 0.96) / 200 - 1
    }
    
    static func getDexterityValue(_ dex: String) -> Double {
        guard let dex = Double(dex) else { return 0 }
        
        return (11 * pow(dex, 0.2)) / 20
    }
    
    static func getAgilityValue(_ agility: String) -> Double {
        guard let agility = Double(agility) else { return 0 }
        
        return (11 * pow(agility, 0.9)) / 1000
    }
    
}
