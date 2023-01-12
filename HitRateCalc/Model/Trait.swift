//
//  Trait.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 1/12/23.
//

import Foundation

struct Trait: Identifiable {
    var id = 0
    var name = ""
    var amount = ""
}

extension Trait {
    static let evasionTraits: [Trait] = [Trait(name: "Agility")] + universalTraits
    static let accuracyTraits: [Trait] = [Trait(name: "Dexterity")] + universalTraits
}

private extension Trait {
    static let universalTraits: [Trait] = [Trait(id: 1, name: "Luck"), Trait(id: 2, name: "Bonus")]
}
