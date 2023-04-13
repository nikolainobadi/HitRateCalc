//
//  VisionDetailsDataModel.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import Foundation

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


// MARK: - ViewModel
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


// MARK: - Private Methods
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
