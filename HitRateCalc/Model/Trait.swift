//
//  Trait.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 1/12/23.
//

import Foundation

struct Trait: Identifiable {
    var id = UUID()
    var name = ""
    var amount = ""
}

extension Trait {
    static let evasionTraits: [Trait] = [Trait(name: "Agility")] + universalTraits
    static let accuracyTraits: [Trait] = [Trait(name: "Dexterity")] + universalTraits
}

private extension Trait {
    static let universalTraits: [Trait] = [Trait(name: "Luck"), Trait(name: "Bonus")]
}
