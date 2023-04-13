//
//  ContentView.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 1/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSettings = false
    @StateObject var dataModel = HitRateDataModel()
    @State private var detailsToShow: TraitDetails?
    
    private var offset: CGFloat { getHeightPercent(20) }
    private var accuracyOffset: CGFloat { dataModel.checkingHitRate ? -offset : offset }
    private var evasionOffset: CGFloat { dataModel.checkingHitRate ? offset : -offset }
    private var evasionRate: String { "\(dataModel.evasionRate)" }
    private var accuracyRate: String { "\(dataModel.accuracyRate)" }
    
    private func toggleMode() { withAnimation { dataModel.toggleMode() } }
    private func clearValues(isEvasion: Bool) { dataModel.clearValues(isEvasion: isEvasion) }
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                
                VStack {
                    ZStack {
                        VStack {
                            TraitsSection(traitList: $dataModel.evasionTraits, title: "Evasion", rateResult: evasionRate, clearValues: { clearValues(isEvasion: true) })
                                .disabled(true)
                        }
                        .offset(y: evasionOffset)
                        .onTapGesture { detailsToShow = .evasion }
                        
                        SwitchButton(action: toggleMode)
                        
                        VStack {
                            TraitsSection(traitList: $dataModel.accuracyTraits, title: "Accuracy", rateResult: accuracyRate, clearValues: { clearValues(isEvasion: false) })
                                .disabled(true)
                        }
                        .offset(y: accuracyOffset)
                        .onTapGesture { detailsToShow = .accuracy }
                            
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                Spacer()
                FinalResult(title: dataModel.finalRateTitle, resultRate: dataModel.finalRate)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle("Hit Rate Calc")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingSettings, content: { SettingsView() })
            .sheet(item: $detailsToShow, content: { details in
                EditableTraitList(traitList: details == .evasion ? $dataModel.evasionTraits : $dataModel.accuracyTraits, isEvasion: details == .evasion)
            })
            .toolbar {
                Button(action: { showingSettings = true }) {
                    Image(systemName: "gearshape")
                        .foregroundColor(.primary)
                }
            }
        }
    }
}


// MARK: - FinalResult
fileprivate struct FinalResult: View {
    let title: String
    let resultRate: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.title3)
                .padding(.horizontal)
            Text("\(resultRate)%")
                .font(.largeTitle.weight(.semibold))
                .minimumScaleFactor(0.5)
                .frame(maxWidth: .infinity, maxHeight: getHeightPercent(8), alignment: .center)
                .padding(.horizontal)
                .withRoundedBorder()
                
        }
    }
}


// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// MARK: - Dependencies
enum TraitDetails: Identifiable {
    case accuracy, evasion
    
    var id: Int {
        switch self {
        case .accuracy: return 0
        case .evasion: return 1
        }
    }
}
