//
//  AdMobId.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/14/23.
//

enum AdMobId: String {
    case openApp = "ca-app-pub-6607027445077729/3838111928"
    
    var testId: String {
        switch self {
        case .openApp: return "ca-app-pub-3940256099942544/5662855259"
        }
    }
}
