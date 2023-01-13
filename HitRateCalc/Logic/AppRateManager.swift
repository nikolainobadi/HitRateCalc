//
//  AppRateManager.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 1/12/23.
//

import StoreKit

final class AppRatingManager: AppRater {
    func rateApp() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}
