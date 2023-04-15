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
            .onlyShow(when: focusedIndex == nil)
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
                Button("Cancel", action: { focusedIndex = nil })
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
                StatRowTitle(title: "Name") {
                    TextField("Unit Name...", text: $dataModel.name)
                        .keyboardType(.alphabet)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.center)
                        .focused($focusedIndex, equals: 0)
                }
            }.onlyShow(when: dataModel.showNameField)
            
            Section {
                StatNumberRow(title: "Luck", number: $dataModel.luck)
                    .focused($focusedIndex, equals: 1)
            }
            
            Section("Evasion") {
                StatNumberRow(title: "Agility", number: $dataModel.agility)
                    .focused($focusedIndex, equals: 2)
                StatNumberRow(title: "Evasion", number: $dataModel.evasion)
                    .focused($focusedIndex, equals: 3)
            }.onlyShow(when: dataModel.showEvasion)
            
            Section("Accuracy") {
                StatNumberRow(title: "Dexterity", number: $dataModel.dexterity)
                    .focused($focusedIndex, equals: 4)
                StatNumberRow(title: "Accuracy", number: $dataModel.accuracy)
                    .focused($focusedIndex, equals: 5)
            }.onlyShow(when: dataModel.showAccuracy)
        }.onAppear { dataModel.focusFirstField() }
    }
}


// MARK: - StatRow
fileprivate struct StatRowTitle<Child: View>: View {
    let title: String
    @ViewBuilder let child: Child
    
    var body: some View {
        HStack {
            Text("\(title):")
                .lineLimit(1)
                .font(.title3)
                .minimumScaleFactor(0.5)
                .frame(maxWidth: getWidthPercent(20), alignment: .leading)
            child
        }
    }
}



// MARK: - StatNumberRow
fileprivate struct StatNumberRow: View {
    let title: String
    @Binding var number: Int
    
    var body: some View {
        StatRowTitle(title: title) {
            IntTextField(integerValue: $number)
        }
    }
}

// MARK: - TraitTextField
fileprivate struct StatTextField: View {
    @Binding var text: String
    
    let title: String
    let keyboardType: UIKeyboardType
    
    private var textLimit: Int { keyboardType == .numberPad ? 3 : 30 }
    private var prompt: String { keyboardType == .numberPad ? "100" : "Unit Name..." }
    
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
            TextField(prompt, text: $text)
                .keyboardType(keyboardType)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
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
        VisionDetailsDataModel(vision: Vision(), state: .allDetails, store: MockStore())
    }
    
    class MockStore: VisionStore {
        func saveVision(_ vision: Vision) async throws { }
    }
}
