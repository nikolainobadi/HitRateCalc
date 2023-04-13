//
//  VisionDetailsView.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import SwiftUI

struct VisionDetailsView: View {
    @StateObject var dataModel: VisionDetailsDataModel
    
    var body: some View {
        Form {
            Section {
                TraitTextField("Name", text: $dataModel.name, keyboardType: .alphabet)
            }.onlyShow(when: dataModel.showNameField)
            
            Section {
                TraitTextField("Luck", text: $dataModel.luck)
            }
            
            Section("Evasion") {
                TraitTextField("Agility", text: $dataModel.agility)
                TraitTextField("Evasion", text: $dataModel.evasion)
            }.onlyShow(when: dataModel.showEvasion)
            
            Section("Accuracy") {
                TraitTextField("Dexterity", text: $dataModel.dexterity)
                TraitTextField("Accuracy", text: $dataModel.accuracy)
            }.onlyShow(when: dataModel.showAccuracy)
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
    var showAccuracy: Bool { state != .evasion}
}


enum VisionDetailState {
    case allDetails, evasion, accuracy
}
