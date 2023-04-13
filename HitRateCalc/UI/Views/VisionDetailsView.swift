//
//  VisionDetailsView.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import SwiftUI

struct VisionDetailsView: View {
    @FocusState private var focusedIndex: Int?
    @Environment(\.dismiss) private var dismiss
    @StateObject var dataModel: VisionDetailsDataModel
    
    var body: some View {
        VStack {
            StatsForm(focusedIndex: _focusedIndex, dataModel: dataModel)
            
            Button(action: dataModel.save) {
                Text("Save")
                    .font(.title)
                    .padding(.horizontal)
            }
            .padding()
            .disabled(!dataModel.canSave)
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color(uiColor: .secondarySystemBackground))
        .bindFocus(focusState: _focusedIndex, publishedFocusState: $dataModel.focusedIndex)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                }
            }
            ToolbarItemGroup(placement: .keyboard) {
                Button(action: { focusedIndex = nil }, label: { Text("Cancel") }).tint(.primary)
                Spacer()
                Button(dataModel.nextButtonText, action: dataModel.nextButtonAction)
            }
        }
    }
}


// MARK: - StatsForm
fileprivate struct StatsForm: View {
    @FocusState var focusedIndex: Int?
    @ObservedObject var dataModel: VisionDetailsDataModel
    
    var body: some View {
        Form {
            Section {
                StatTextField("Name", text: $dataModel.name, keyboardType: .alphabet)
                    .focused($focusedIndex, equals: 0)
            }.onlyShow(when: dataModel.showNameField)
            
            Section {
                StatTextField("Luck", text: $dataModel.luck)
                    .focused($focusedIndex, equals: 1)
            }
            
            Section("Evasion") {
                StatTextField("Agility", text: $dataModel.agility)
                    .focused($focusedIndex, equals: 2)
                StatTextField("Evasion", text: $dataModel.evasion)
                    .focused($focusedIndex, equals: 3)
            }.onlyShow(when: dataModel.showEvasion)
            
            Section("Accuracy") {
                StatTextField("Dexterity", text: $dataModel.dexterity)
                    .focused($focusedIndex, equals: 4)
                StatTextField("Accuracy", text: $dataModel.accuracy)
                    .focused($focusedIndex, equals: 5)
            }.onlyShow(when: dataModel.showAccuracy)
        }
    }
}


// MARK: - TraitTextField
fileprivate struct StatTextField: View {
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
                .onTapGesture {
                    if text == "0" {
                        text = ""
                    }
                }
        }.onChange(of: text) { newValue in
            if newValue.count > 3 {
                text = String(newValue.prefix(3))
            }
        }

    }
}


// MARK: - Preview
struct VisionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VisionDetailsView(dataModel: dataModel)
        }
    }
    
    static var dataModel: VisionDetailsDataModel {
        VisionDetailsDataModel(vision: Vision(), state: .allDetails, completion: { _ in })
    }
}
