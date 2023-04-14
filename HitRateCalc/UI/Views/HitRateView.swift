//
//  HitRateView.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import SwiftUI

struct HitRateView: View {
    @Binding var path: NavigationPath
    @ObservedObject var dataModel: HitRateDataModel
    
    private var offset: CGFloat { getHeightPercent(20) }
    private var evasionOffset: CGFloat { dataModel.checkingHitRate ? offset : -offset }
    private var accuracyOffset: CGFloat { dataModel.checkingHitRate ? -offset : offset }
    
    private func showUnitList(with vision: Vision) {
        path.append(vision)
    }
    
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    VisionStatsContainer(viewModel: .accuracy(dataModel.attacker), resetValues: dataModel.resetAttacker, showUnitList: showUnitList(with:))
                        .offset(y: accuracyOffset)
                        .onTapGesture {
                            dataModel.editAttacker()
                        }
                    
                    SwitchButton(action: { dataModel.checkingHitRate.toggle() })
                    
                    VisionStatsContainer(viewModel: .evasion(dataModel.defender), resetValues: dataModel.resetDefender, showUnitList: showUnitList(with:))
                        .offset(y: evasionOffset)
                        .onTapGesture {
                            dataModel.editDefender()
                        }
                }
                .animation(.default, value: dataModel.checkingHitRate)
                .frame(maxWidth: .infinity, maxHeight: .infinity) // prevents view from moving off-screen
            }
            
            Spacer()
            FinalResultView(title: dataModel.finalRateTitle, resultRate: dataModel.finalRate)
        }
    }
}



// MARK: - Preview
struct HitRateView_Previews: PreviewProvider {
    static var previews: some View {
        HitRateView(path: .constant(NavigationPath()), dataModel: HitRateDataModel())
    }
}
