//
//  VisionDetailsDataModel.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import Foundation

final class VisionDetailsDataModel: ObservableObject {
    @Published var name: String
    @Published var luck: Int
    @Published var agility: Int
    @Published var dexterity: Int
    @Published var evasion: Int
    @Published var accuracy: Int
    @Published var focusedIndex: Int?
    
    private let originalVision: Vision
    private let state: VisionDetailState
    private let store: VisionStore
    
    init(vision: Vision, state: VisionDetailState, store: VisionStore) {
        self.state = state
        self.originalVision = vision
        self.store = store
        self.name = originalVision.name
        self.luck = originalVision.luck
        self.agility = originalVision.agility
        self.dexterity = originalVision.dexterity
        self.evasion = originalVision.evasion
        self.accuracy = originalVision.accuracy
    }
}


// MARK: - ViewModel
extension VisionDetailsDataModel {
    var showNameField: Bool { state == .allDetails }
    var showEvasion: Bool { state != .accuracy }
    var showAccuracy: Bool { state != .evasion }
    var nextButtonText: String {
        guard let focusedIndex = focusedIndex else { return "" }
        
        return focusedIndex < finalFieldIndex ? "Next" : "Done"
    }
    
    var canSave: Bool {
        switch state {
        case .allDetails:
            return !name.isEmpty
        case .accuracy:
            return true
        case .evasion:
            return true
        }
    }
    
    func focusFirstField() { focusedIndex = availableFieldIndices.first }
    func nextButtonAction() {
        guard let focusedIndex = focusedIndex else { return }
        guard let currentIndex = availableFieldIndices.firstIndex(where: { $0 == focusedIndex }) else { return }
        
        if currentIndex < (availableFieldIndices.count - 1) {
            self.focusedIndex = availableFieldIndices[currentIndex + 1]
        } else {
            self.focusedIndex = nil
        }
    }
    
    func save() {
        // MARK: - TODO
        // add proper error handling
        Task {
            do {
                try await store.saveVision(updatedVision)
            } catch {
                print(error.localizedDescription)
            }
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
    
    var updatedVision: Vision {
        var updated = originalVision
        
        updated.name = name
        updated.luck = luck
        updated.agility = agility
        updated.dexterity = dexterity
        updated.accuracy = accuracy
        updated.evasion = evasion
        
        return updated
    }
}


// MARK: - Dependencies
protocol VisionStore {
    func saveVision(_ vision: Vision) async throws
}
