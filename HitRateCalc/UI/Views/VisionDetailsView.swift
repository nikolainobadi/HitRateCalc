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

final class VisionDetailsDataModel: ObservableObject {
    @Published var name: String
    @Published var luck: String
    @Published var agility: String
    @Published var dexterity: String
    @Published var evasion: String
    @Published var accuracy: String
    @Published var focusedIndex: Int?
    
    private let originalVision: Vision
    private let state: VisionDetailState
    
    init(vision: Vision, state: VisionDetailState) {
        self.state = state
        self.originalVision = vision
        self.name = originalVision.name
        self.luck = "\(originalVision.luck)"
        self.agility = "\(originalVision.agility)"
        self.dexterity = "\(originalVision.dexterity)"
        self.evasion = "\(originalVision.evasion)"
        self.accuracy = "\(originalVision.accuracy)"
    }
}

extension VisionDetailsDataModel {
    var showNameField: Bool { state ==  .allDetails }
    var showEvasion: Bool { state != .accuracy }
    var showAccuracy: Bool { state != .evasion }
    var nextButtonText: String {
        guard let focusedIndex = focusedIndex else { return "" }
        
        return focusedIndex < finalFieldIndex ? "Next" : "Done"
    }
    
    func nextButtonAction() {
        guard let focusedIndex = focusedIndex else { return }
        guard let currentIndex = availableFieldIndices.firstIndex(where: { $0 == focusedIndex }) else { return }
        
        if currentIndex < (availableFieldIndices.count - 1) {
            self.focusedIndex = availableFieldIndices[currentIndex + 1]
        } else {
            self.focusedIndex = nil
        }
    }
}

private extension VisionDetailsDataModel {
    var finalFieldIndex: Int { state == .evasion ? 3 : 5 }
    var availableFieldIndices: [Int] {
        switch state {
        case .allDetails: return [0, 1, 2, 3, 4, 5]
        case .evasion: return [1, 2, 3]
        case .accuracy: return [1, 4, 5]
        }
    }
}


enum VisionDetailState {
    case allDetails, evasion, accuracy
}

struct BindFocusStateViewModifier: ViewModifier {
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
        modifier(BindFocusStateViewModifier(focusState: focusState, publishedFocus: publishedFocusState))
    }
}
