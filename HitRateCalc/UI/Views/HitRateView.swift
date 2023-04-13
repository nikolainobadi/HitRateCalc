//
//  HitRateView.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import SwiftUI

struct HitRateView: View {
    @StateObject private var dataModel = HitRateDataModel()
    @State private var selectedInfo: StatsContainerInfo?
    
    private var offset: CGFloat { getHeightPercent(20) }
    private var evasionOffset: CGFloat { dataModel.checkingHitRate ? offset : -offset }
    private var accuracyOffset: CGFloat { dataModel.checkingHitRate ? -offset : offset }
    
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
            .sheet(item: $selectedInfo) { info in
                showDetails(info) { updatedVision in
                    switch info {
                    case .evasion:
                        dataModel.defender = updatedVision
                    case .accuracy:
                        dataModel.attacker = updatedVision
                    }
                }
            }
        }
    }
}


// MARK: - Subviews
private extension HitRateView {
    func showDetails(_ info: StatsContainerInfo, completion: ((Vision) -> Void)? = nil) -> some View {
        let dataModel = makeDataModel(info)
        
        return VisionDetailsView(dataModel: dataModel)
    }
    
    func makeDataModel(_ info: StatsContainerInfo) -> VisionDetailsDataModel {
        switch info {
        case .evasion(let vision):
            return VisionDetailsDataModel(vision: vision, state: .evasion)
        case .accuracy(let vision):
            return VisionDetailsDataModel(vision: vision, state: .accuracy)
        }
    }
}


// MARK: - Preview
struct HitRateView_Previews: PreviewProvider {
    static var previews: some View {
        HitRateView()
    }
}
