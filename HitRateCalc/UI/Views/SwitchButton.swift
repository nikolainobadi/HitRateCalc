//
//  SwitchButton.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import SwiftUI

struct SwitchButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "arrow.up.arrow.down")
                .font(.largeTitle)
                .cornerRadius(1)
        }
        .tint(.black)
        .buttonStyle(.borderedProminent)
        .padding(.top, getHeightPercent(5))
        .shadow(color: .primary, radius: 4)
    }
}

struct SwitchButton_Previews: PreviewProvider {
    static var previews: some View {
        SwitchButton(action: { })
    }
}
