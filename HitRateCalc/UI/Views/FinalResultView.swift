//
//  FinalResultView.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import SwiftUI

struct FinalResultView: View {
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
struct FinalResultView_Previews: PreviewProvider {
    static var previews: some View {
        FinalResultView(title: "Chance to evade", resultRate: "100")
    }
}
