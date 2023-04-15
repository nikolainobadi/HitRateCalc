//
//  LaunchCoordinatorView.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/14/23.
//

import SwiftUI

struct LaunchCoordinatorView: View {
    @Binding var isInitialLaunch: Bool
    
    var body: some View {
        HitRateCoordinatorView()
            .onAppear {
                ATTAdapter.initializeAdService()
                
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                    if isInitialLaunch {
                        isInitialLaunch = false
                    } else {
                        AppOpenAdManager.shared.showAdIfAvailable()
                    }
                }
            }
    }
}
