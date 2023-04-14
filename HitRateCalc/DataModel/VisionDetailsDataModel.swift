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
    private let store: VisionStore
    
    init(vision: Vision, state: VisionDetailState, store: VisionStore) {
        self.state = state
        self.originalVision = vision
        self.store = store
        self.name = originalVision.name
        self.luck = "\(originalVision.luck)"
        self.agility = "\(originalVision.agility)"
        self.dexterity = "\(originalVision.dexterity)"
        self.evasion = "\(originalVision.evasion)"
        self.accuracy = "\(originalVision.accuracy)"
        self.adjustValues()
    }
}


// MARK: - ViewModel
extension VisionDetailsDataModel {
    var showNameField: Bool { state == .allDetails && (focusedIndex == nil || focusedIndex == 0) }
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
        updated.luck = Int(luck) ?? 0
        updated.agility = Int(agility) ?? 0
        updated.dexterity = Int(dexterity) ?? 0
        updated.accuracy = Int(accuracy) ?? 0
        updated.evasion = Int(evasion) ?? 0
        
        return updated
    }
    
    func adjustValues() {
        if luck == "0" { luck = "" }
        if agility == "0" { agility = "" }
        if evasion == "0" { evasion = "" }
        if dexterity == "0" { dexterity = "" }
        if accuracy == "0" { accuracy = "" }
    }
}


// MARK: - Dependencies
protocol VisionStore {
    func saveVision(_ vision: Vision) async throws
}

final class VisionStoreAdapter {
    private let store: VisionStore
    private let completion: (Vision) -> Void
    
    init(store: VisionStore, completion: @escaping (Vision) -> Void) {
        self.store = store
        self.completion = completion
    }
}

extension VisionStoreAdapter: VisionStore {
    func saveVision(_ vision: Vision) async throws {
        try await store.saveVision(vision)
        await finished(vision)
    }
}

private extension VisionStoreAdapter {
    @MainActor func finished(_ vision: Vision) { completion(vision) }
}
