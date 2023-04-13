//
//  ConditionalDisplayViewModifier.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import SwiftUI

struct ConditionalDisplayViewModifier: ViewModifier {
    let conditional: Bool
    
    func body(content: Content) -> some View {
        if conditional {
            content
        }
    }
}

extension View {
    func onlyShow(when conditional: Bool) -> some View {
        modifier(ConditionalDisplayViewModifier(conditional: conditional))
    }
}
