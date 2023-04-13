//
//  HitRateView.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import SwiftUI

struct HitRateView: View {
    @State private var firstVision = Vision()
    @State private var secondVision = Vision()
    @State private var checkingHitRate = true
    
    private var offset: CGFloat { getHeightPercent(20) }
    private var accuracyOffset: CGFloat { checkingHitRate ? -offset : offset }
    private var evasionOffset: CGFloat { checkingHitRate ? offset : -offset }
    private var finalRateTitle: String { "Chance to \(checkingHitRate ? "hit" : "evade") enemy unit" }
    private var finalRate: String {
        let hitRate = HitRateCalculator.getHitRate(attacker: firstVision, defender: secondVision)
        
        return String(checkingHitRate ? hitRate : (100 - hitRate))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    ZStack {
                        VisionStatsContainer(viewModel: .accuracy(firstVision))
                            .offset(y: accuracyOffset)
                        
                        SwitchButton(action: { checkingHitRate.toggle() })
                        
                        VisionStatsContainer(viewModel: .evasion(secondVision))
                            .offset(y: evasionOffset)
                    }
                    .animation(.default, value: checkingHitRate)
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // prevents view from moving off-screen
                }
                
                Spacer()
                FinalResultView(title: finalRateTitle, resultRate: finalRate)
            }
            .navigationTitle("Hit-Rate Calc")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


// MARK: - Preview
struct HitRateView_Previews: PreviewProvider {
    static var previews: some View {
        HitRateView()
    }
}
