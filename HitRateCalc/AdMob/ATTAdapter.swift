//
//  ATTAdapter.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/14/23.
//

import Foundation
import GoogleMobileAds
import AppTrackingTransparency

enum ATTAdapter {
    static func initializeAdService() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            ATTrackingManager.requestTrackingAuthorization { status in
                GADMobileAds.sharedInstance().start()
                GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ GADSimulatorID ]
            }
        }
    }
}

