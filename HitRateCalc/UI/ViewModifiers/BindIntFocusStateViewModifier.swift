//
//  BindIntFocusStateViewModifier.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import SwiftUI

struct BindIntFocusStateViewModifier: ViewModifier {
    @FocusState var focusState: Int?
    @Binding var publishedFocus: Int?

    func body(content: Content) -> some View {
        content
            .onChange(of: focusState, perform: { publishedFocus = $0 })
            .onChange(of: publishedFocus, perform: { focusState = $0 })
    }
}

extension View {
    func bindFocus(focusState: FocusState<Int?>, publishedFocusState: Binding<Int?>) -> some View {
        modifier(BindIntFocusStateViewModifier(focusState: focusState, publishedFocus: publishedFocusState))
    }
}
