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
                        VisionStatsContainer(viewModel: .accuracy(dataModel.attacker), resetValues: dataModel.resetAttacker)
                            .offset(y: accuracyOffset)
                            .onTapGesture {
                                selectedInfo = .accuracy(dataModel.attacker)
                            }
                        
                        SwitchButton(action: { dataModel.checkingHitRate.toggle() })
                        
                        VisionStatsContainer(viewModel: .evasion(dataModel.defender), resetValues: dataModel.resetDefender)
                            .offset(y: evasionOffset)
                            .onTapGesture {
                                selectedInfo = .evasion(dataModel.defender)
                            }
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
                NavigationStack {
                    showDetails(info) { updatedVision in
                        switch info {
                        case .evasion:
                            dataModel.defender = updatedVision
                        case .accuracy:
                            dataModel.attacker = updatedVision
                        }
                        
                        self.selectedInfo = nil
                    }.navigationTitle(info.title)
                }
                
            }
        }
    }
}


// MARK: - Subviews
private extension HitRateView {
    func showDetails(_ info: StatsContainerInfo, completion: ((Vision) -> Void)? = nil) -> some View {
        let dataModel = makeDataModel(info, completion: completion)
        
        return VisionDetailsView(dataModel: dataModel)
    }
    
    func makeDataModel(_ info: StatsContainerInfo, completion: ((Vision) -> Void)?) -> VisionDetailsDataModel {
        switch info {
        case .evasion(let vision):
            return VisionDetailsDataModel(vision: vision, state: .evasion, completion: completion ?? { _ in })
        case .accuracy(let vision):
            return VisionDetailsDataModel(vision: vision, state: .accuracy, completion: completion ?? { _ in })
        }
    }
}


// MARK: - Preview
struct HitRateView_Previews: PreviewProvider {
    static var previews: some View {
        HitRateView()
    }
}
