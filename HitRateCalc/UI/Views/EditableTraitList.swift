//
//  EditableTraitList.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 1/12/23.
//

import SwiftUI

struct EditableTraitList: View {
    @Binding var traitList: [Trait]
    @FocusState private var focusedIndex: Int?
    @Environment(\.dismiss) private var dismiss
    
    private var nextButtonText: String { focusedIndex != 2 ? "Next" : "Done" }
    
    private func nextAction() {
        if let focusedIndex = focusedIndex {
            if focusedIndex < 2 {
                self.focusedIndex = (focusedIndex + 1)
            } else {
                dismiss()
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ForEach($traitList) { trait in
                    TraitRow(trait: trait)
                        .focused($focusedIndex, equals: trait.id)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.title)
                        
                    }
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    Button(action: { focusedIndex = nil }, label: { Text("Cancel") })
                    Spacer()
                    Button(action: nextAction, label: { Text(nextButtonText) })
                }
            }
        }
    }
}


// MARK: - Preview
struct EditableTraitList_Previews: PreviewProvider {
    static var previews: some View {
        EditableTraitList(traitList: .constant(Trait.evasionTraits))
    }
}
