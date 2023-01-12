//
//  TraitList.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 1/12/23.
//

import SwiftUI

struct TraitList: View {
    @Binding var traitList: [Trait]
    
    var body: some View {
        List($traitList) { trait in
            TraitRow(trait: trait)
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
        TraitList(traitList: .constant(Trait.evasionTraits))
    }
}
