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
    private func showUnitList(with info: StatsContainerInfo) { path.append(info) }
    
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    VisionStatsContainer(viewModel: .accuracy(dataModel.attacker), resetValues: dataModel.resetAttacker, showUnitList: showUnitList(with:))
                        .offset(y: dataModel.checkingHitRate ? -offset : offset)
                        .onTapGesture {
                            dataModel.editAttacker()
                        }
                    
                    SwitchButton(action: { dataModel.checkingHitRate.toggle() })
                    
                    VisionStatsContainer(viewModel: .evasion(dataModel.defender), resetValues: dataModel.resetDefender, showUnitList: showUnitList(with:))
                        .offset(y: dataModel.checkingHitRate ? offset : -offset)
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
