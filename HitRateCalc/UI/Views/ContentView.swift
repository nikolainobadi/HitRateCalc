//
//  ContentView.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 1/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dataModel = HitRateDataModel()
    
    private var offset: CGFloat { getHeightPercent(20) }
    private var accuracyOffset: CGFloat { dataModel.checkingHitRate ? -offset : offset }
    private var evasionOffset: CGFloat { dataModel.checkingHitRate ? offset : -offset }
    private var evasionRate: String { "\(dataModel.evasionRate)" }
    private var accuracyRate: String { "\(dataModel.accuracyRate)" }
    
    private func toggleMode() {
        withAnimation { dataModel.toggleMode() }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                
                VStack {
                    ZStack {
                        TraitsSection(traitList: $dataModel.evasionTraits, title: "Evasion", rateResult: evasionRate)
                            .offset(y: evasionOffset)
                        
                        Button(action: toggleMode) {
                            Image(systemName: "arrow.up.arrow.down")
                                .font(.largeTitle)
                                .cornerRadius(1)
                        }
                        .tint(.black)
                        .buttonStyle(.borderedProminent)
                        .padding(.top, getHeightPercent(5))
                        .shadow(color: .primary, radius: 4)
                        
                        TraitsSection(traitList: $dataModel.accuracyTraits, title: "Accuracy", rateResult: accuracyRate)
                            .offset(y: accuracyOffset)
                            
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                Spacer()
                VStack(spacing: 0) {
                    Text(dataModel.finalRateTitle)
                    Text(dataModel.finalRate)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle("Hit Rate Calc")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(action: { }) {
                    Image(systemName: "gearshape")
                        .foregroundColor(.primary)
                }
            }
        }
    }
}


// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// MARK: - DataModel
final class HitRateDataModel: ObservableObject {
    @Published var checkingHitRate = false
    @Published var evasionTraits = Trait.evasionTraits
    @Published var accuracyTraits = Trait.accuracyTraits
    
}

extension HitRateDataModel {
    var finalRate: String { checkingHitRate ? hitRate : changeToEvade }
    var finalRateTitle: String { "Chance to \(checkingHitRate ? "hit" : "evade") enemy unit" }
    
    var evasionRate: Int {
        let evadeAmounts = evasionTraits.map({ $0.amount})
        
        return HitRateCalculator.getEvasionRate(agility: evadeAmounts[0], luck: evadeAmounts[1], bonus: evadeAmounts[2])
    }
    
    var accuracyRate: Int {
        let accAmounts = accuracyTraits.map({ $0.amount })
        
        return HitRateCalculator.getAccuracyRate(dex: accAmounts[0], luck: accAmounts[1], bonus: accAmounts[2])
    }
    
    func toggleMode() { checkingHitRate.toggle() }
}

private extension HitRateDataModel {
    var hitRate: String {
        "\(HitRateCalculator.getHitRate(accuracyRate: accuracyRate, evasionRate: evasionRate))"
    }
    
    var changeToEvade: String {
        "\(HitRateCalculator.getChanceToEvade(evasionRate: evasionRate, accuracyRate: accuracyRate))"
    }
}
