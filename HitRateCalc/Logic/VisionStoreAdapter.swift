//
//  VisionStoreAdapter.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/14/23.
//

import Foundation

final class VisionStoreAdapter {
    private let store: VisionStore
    private let completion: (Vision) -> Void
    
    init(store: VisionStore, completion: @escaping (Vision) -> Void) {
        self.store = store
        self.completion = completion
    }
}


// MARK: - VisionStore
extension VisionStoreAdapter: VisionStore {
    func saveVision(_ vision: Vision) async throws {
        if !vision.name.isEmpty {
            try await store.saveVision(vision)
        }
        await finished(vision)
    }
}


// MARK: - Private Methods
private extension VisionStoreAdapter {
    @MainActor func finished(_ vision: Vision) { completion(vision) }
}
