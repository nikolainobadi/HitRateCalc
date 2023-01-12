//
//  RoundedBorderViewModifier.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 1/12/23.
//

import SwiftUI

struct RoundedBorderViewModifier: ViewModifier {
    let withPadding: Bool
    let withShadow: Bool
    
    func body(content: Content) -> some View {
        content
            .background()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(1)
            .background(Color(uiColor: .label))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, withPadding ? 16 : 0)
            .shadow(color: Color(uiColor: .label), radius: withShadow ? 4 : 0)
    }
}

extension View {
    func withRoundedBorder(withPadding: Bool = true, withShadow: Bool = true) -> some View {
        modifier(RoundedBorderViewModifier(withPadding: withPadding, withShadow: withShadow))
    }
}

