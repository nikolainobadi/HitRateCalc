//
//  TraitList.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 1/12/23.
//

import SwiftUI

struct TraitsSection: View {
    @Binding var traitList: [Trait]
    
    let title: String
    let rateResult: String
    let clearValues: () -> Void
    
    private var showClearButton: Bool {
        traitList.compactMap({ Double($0.amount) ?? 0 }).reduce(0, +) > 0
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            HStack {
                TraitList(traitList: $traitList)
                Divider().frame(maxHeight: getHeightPercent(21))
                VStack {
                    if showClearButton {
                        Button(action: clearValues) {
                            Text("Clear values")
                                .underline()
                                .font(.caption)
                        }.padding(5)
                    }
                    Spacer()
                    Text("\(rateResult)%")
                        .lineLimit(1)
                        .font(.largeTitle)
                        .minimumScaleFactor(0.5)
                        .frame(maxWidth: getWidthPercent(25))
                    Spacer()
                }.frame(maxHeight: getHeightPercent(21))
            }.withRoundedBorder()
        }
    }
}

struct TraitList: View {
    @Binding var traitList: [Trait]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach($traitList) { trait in
                TraitRow(trait: trait)
                if trait.id != 2 {
                    Divider().background(Color(uiColor: .systemBackground))
                }
            }
        }
    }
}


// MARK: - Row
struct TraitRow: View {
    @Binding var trait: Trait
    
    var body: some View {
        HStack(spacing: 0) {
            TitleLabel(title: trait.name)
            AmountField(amount: $trait.amount)
        }.frame(maxHeight: getHeightPercent(7))
    }
}


// MARK: - Title
fileprivate struct TitleLabel: View {
    let title: String
    
    var body: some View {
        Text(title)
            .lineLimit(1)
            .font(.title3.weight(.heavy))
            .minimumScaleFactor(0.5)
            .foregroundColor(Color(uiColor: .systemBackground))
            .padding(.horizontal, 5)
            .frame(maxWidth: getWidthPercent(25), maxHeight: .infinity, alignment: .center)
            .background(Color(uiColor: .label))
    }
}


// MARK: - AmountField
fileprivate struct AmountField: View {
    @Binding var amount: String
    
    var body: some View {
        TextField("0", text: $amount)
            .font(.title)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(10)
            .padding(10)
    }
}

// MARK: - Preview
struct TraitList_Previews: PreviewProvider {
    static var previews: some View {
        TraitsSection(traitList: .constant(Trait.evasionTraits), title: "Evasion", rateResult: "0", clearValues: { })
    }
}
