//
//  ContentView.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 1/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dataModel = HitRateDataModel()
    
    private var evasionRate: String { "\(dataModel.evasionRate)" }
    private var accuracyRate: String { "\(dataModel.accuracyRate)" }
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                
                TraitsSection(traitList: $dataModel.evasionTraits, title: "Evasion", rateResult: evasionRate)
                
                TraitsSection(traitList: $dataModel.accuracyTraits, title: "Accuracy", rateResult: accuracyRate)
                
                VStack(spacing: 0) {
                    Text("Chance to evade enemy unit")
                    Text("")
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
    @Published var evasionTraits = Trait.evasionTraits
    @Published var accuracyTraits = Trait.accuracyTraits
}

extension HitRateDataModel {
    var evasionRate: Int {
        let evadeAmounts = evasionTraits.map({ $0.amount})
        
        return HitRateCalculator.getEvasionRate(agility: evadeAmounts[0], luck: evadeAmounts[1], bonus: evadeAmounts[2])
    }
    
    var accuracyRate: Int {
        let accAmounts = accuracyTraits.map({ $0.amount })
        
        return HitRateCalculator.getAccuracyRate(dex: accAmounts[0], luck: accAmounts[1], bonus: accAmounts[2])
    }
}
