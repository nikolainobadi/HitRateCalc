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
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            HStack {
                TraitList(traitList: $traitList)
                VStack {
                    Spacer()
                    Text("\(rateResult)%")
                        .lineLimit(1)
                        .font(.largeTitle)
                        .minimumScaleFactor(0.5)
                    Spacer()
                    Text("Estimated Result")
                        .padding(5)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }.frame(maxHeight: getHeightPercent(21))
            }.withRoundedBorder()
        }
    }
}

struct TraitList: View {
    @Binding var traitList: [Trait]
    
    var body: some View {
        VStack {
            ForEach($traitList) { trait in
                TraitRow(trait: trait)
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
        }
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
        TraitsSection(traitList: .constant(Trait.evasionTraits), title: "Evasion", rateResult: "0")
    }
}
