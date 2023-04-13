//
//  VisionDetailsView.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import SwiftUI

struct VisionDetailsView: View {
    @FocusState private var focusedIndex: Int?
    @StateObject var dataModel: VisionDetailsDataModel
    
    var body: some View {
        Form {
            Section {
                TraitTextField("Name", text: $dataModel.name, keyboardType: .alphabet)
                    .focused($focusedIndex, equals: 0)
            }.onlyShow(when: dataModel.showNameField)
            
            Section {
                TraitTextField("Luck", text: $dataModel.luck)
                    .focused($focusedIndex, equals: 1)
            }
            
            Section("Evasion") {
                TraitTextField("Agility", text: $dataModel.agility)
                    .focused($focusedIndex, equals: 2)
                TraitTextField("Evasion", text: $dataModel.evasion)
                    .focused($focusedIndex, equals: 3)
            }.onlyShow(when: dataModel.showEvasion)
            
            Section("Accuracy") {
                TraitTextField("Dexterity", text: $dataModel.dexterity)
                    .focused($focusedIndex, equals: 4)
                TraitTextField("Accuracy", text: $dataModel.accuracy)
                    .focused($focusedIndex, equals: 5)
            }.onlyShow(when: dataModel.showAccuracy)
        }
        .bindFocus(focusState: _focusedIndex, publishedFocusState: $dataModel.focusedIndex)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button(action: { focusedIndex = nil }, label: { Text("Cancel") }).tint(.primary)
                Spacer()
                Button(dataModel.nextButtonText, action: dataModel.nextButtonAction)
            }
        }
    }
}


// MARK: - TraitTextField
fileprivate struct TraitTextField: View {
    @Binding var text: String
    
    let title: String
    let keyboardType: UIKeyboardType
    
    init(_ title: String, text: Binding<String>, keyboardType: UIKeyboardType = .numberPad) {
        self.title = title
        self._text = text
        self.keyboardType = keyboardType
    }
    
    var body: some View {
        HStack {
            Text("\(title):")
                .lineLimit(1)
                .font(.title3)
                .minimumScaleFactor(0.5)
                .frame(maxWidth: getWidthPercent(20), alignment: .leading)
            TextField("", text: $text)
                .keyboardType(keyboardType)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
        }
    }
}


// MARK: - Preview
struct VisionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        VisionDetailsView(dataModel: dataModel)
    }
    
    static var dataModel: VisionDetailsDataModel {
        VisionDetailsDataModel(vision: Vision(), state: .allDetails)
    }
}