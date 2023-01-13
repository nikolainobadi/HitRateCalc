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
    
    let isEvasion: Bool
    
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
                        .tint(.primary)
                        .focused($focusedIndex, equals: trait.id)
                }
            }
            .withRoundedBorder()
            .onAppear { focusedIndex = 0 }
            .navigationTitle(isEvasion ? "Evasion" : "Accuracy")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.title)
                            .tint(.primary)
                    }
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    Button(action: { focusedIndex = nil }, label: { Text("Cancel") }).tint(.primary)
                    Spacer()
                    Button(action: nextAction, label: { Text(nextButtonText) }).tint(.primary)
                }
            }
        }
    }
}


// MARK: - Preview
struct EditableTraitList_Previews: PreviewProvider {
    static var previews: some View {
        EditableTraitList(traitList: .constant(Trait.evasionTraits), isEvasion: false)
    }
}
