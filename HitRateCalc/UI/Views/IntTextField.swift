//
//  IntTextField.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/14/23.
//

import SwiftUI

struct IntTextField: View {
    @Binding var integerValue: Int
    
    var body: some View {
        TextField("100", text: Binding(
            get: {
                integerValue == 0 ? "" : "\(integerValue)"
            },
            set: {
                if let value = Int($0) {
                    let digits = String(value)
                    if digits.count <= 3 {
                        integerValue = value
                    } else {
                        let truncatedValue = Int(String(digits.prefix(3))) ?? 0
                        integerValue = truncatedValue
                    }
                }
            }
        ))
        .keyboardType(.numberPad)
        .textFieldStyle(.roundedBorder)
        .multilineTextAlignment(.center)
    }
}
