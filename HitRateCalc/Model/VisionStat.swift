//
//  VisionStat.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import Foundation

struct VisionStat: Identifiable {
    let name: String
    let amount: Int
    
    var id: String { name }
    var value: String { "\(amount)" }
}
