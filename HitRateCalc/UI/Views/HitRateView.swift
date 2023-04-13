//
//  HitRateView.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import SwiftUI

struct HitRateView: View {
    @StateObject private var dataModel = HitRateDataModel()
    
    private var offset: CGFloat { getHeightPercent(20) }
    private var accuracyOffset: CGFloat { dataModel.checkingHitRate ? -offset : offset }
    private var evasionOffset: CGFloat { dataModel.checkingHitRate ? offset : -offset }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    ZStack {
                        VisionStatsContainer(viewModel: .accuracy(dataModel.attacker))
                            .offset(y: accuracyOffset)
                        
                        SwitchButton(action: { dataModel.checkingHitRate.toggle() })
                        
                        VisionStatsContainer(viewModel: .evasion(dataModel.defender))
                            .offset(y: evasionOffset)
                    }
                    .animation(.default, value: dataModel.checkingHitRate)
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // prevents view from moving off-screen
                }
                
                Spacer()
                FinalResultView(title: dataModel.finalRateTitle, resultRate: dataModel.finalRate)
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
