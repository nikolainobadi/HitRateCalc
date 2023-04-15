//
//  AppOpenManager.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/14/23.
//

import Foundation
import GoogleMobileAds
import AppTrackingTransparency

final class AppOpenAdManager: NSObject {
    static let shared = AppOpenAdManager()
    
    private var completion: (() -> Void)?
    
    var isLoadingAd = false
    var isShowingAd = false
    var appOpenAd: GADAppOpenAd?
    var loadTime: Date?
}

extension AppOpenAdManager {
    func showAdIfAvailable(completion: (() -> Void)? = nil ) {
        let rootVC = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map {$0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .filter { $0.isKeyWindow }
            .first?.rootViewController

        if isShowingAd {
            print("App open ad is already showing.")
            completion?()
            return
        }
        
        if !isAdAvailable() {
            print("App open ad is not ready yet.")
            completion?()
            loadAd()
            return
        }
        
        if let ad = appOpenAd, let rootVC = rootVC, wasLoadTimeLessThanNHoursAgo(thresholdN: 4) {
            isShowingAd = true
            
            self.completion = completion // acts as 'delegate', called when ad dismissed
            ad.present(fromRootViewController: rootVC)
        } else {
            loadAd()
            completion?()
        }
    }
}


// MARK: - FullScreenDelegate
extension AppOpenAdManager: GADFullScreenContentDelegate {
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("App open ad is will be presented.")
    }
    
    func adDidRecordClick(_ ad: GADFullScreenPresentingAd) {
        print("launch ad clicked")
    }
    
    func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) {
        print("launch ad shown")
    }
    
    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        appOpenAd = nil
        isShowingAd = false
        finished()
        loadAd()
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        appOpenAd = nil
        isShowingAd = false
        finished()
        loadAd()
    }
}


// MARK: - Private Methods
private extension AppOpenAdManager {
    func loadAd() {
        if isLoadingAd { return }
        
        isLoadingAd = true

        let request = makeGADRequest()
        
        GADAppOpenAd.load(withAdUnitID: AdMobId.openApp.rawValue, request: request, orientation: .portrait) { appOpenAd, error in
            self.isLoadingAd = false
            
            if let error = error {
                self.appOpenAd = nil
                self.loadTime = nil
                print("App open ad failed to load with error: \(error.localizedDescription).")
                return
            }
            
            self.appOpenAd = appOpenAd
            self.loadTime = Date()
            self.appOpenAd?.fullScreenContentDelegate = self
        }
    }
    
    func isAdAvailable() -> Bool {
        return appOpenAd != nil
    }
    
    func wasLoadTimeLessThanNHoursAgo(thresholdN: Int) -> Bool {
        let now = Date()
        let timeIntervalBetweenNowAndLoadTime = now.timeIntervalSince(loadTime ?? Date())
        let secondsPerHour = 3600.0
        let intervalInHours = timeIntervalBetweenNowAndLoadTime / secondsPerHour
        
        return intervalInHours < Double(thresholdN)
    }
    
    func finished() {
        completion?()
        completion = nil
    }
    
    func makeGADRequest() -> GADRequest {
        let request = GADRequest()
        
        request.requestAgent = ATTrackingManager.trackingAuthorizationStatus == .authorized ? "Ads/GMA_IDFA" : "Ads/GMA"
        
        return request
    }
}

