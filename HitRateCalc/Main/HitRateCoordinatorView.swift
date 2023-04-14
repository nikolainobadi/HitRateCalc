//
//  HitRateCoordinatorView.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import SwiftUI

struct HitRateCoordinatorView: View {
    @State private var path = NavigationPath()
    @StateObject private var dataModel = HitRateDataModel()
    
    var body: some View {
        NavigationStack(path: $path) {
            HitRateView(path: $path, dataModel: dataModel)
                .navigationTitle("Hit-Rate Calc")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: StatsContainerInfo.self, destination: { info in
                    UnitListView(currentVision: dataModel.getVisionToReplace(info: info))
                })
                .sheet(item: $dataModel.selectedInfo) { info in
                    NavigationStack {
                        showDetails(info) { updatedVision in
                            updateVision(updatedVision: updatedVision, info: info)
                            dataModel.selectedInfo = nil
                        }.navigationTitle(info.title)
                    }
                }
        }
    }
}


// MARK: - Private Methods
private extension HitRateCoordinatorView {
    func updateVision(updatedVision: Vision, info: StatsContainerInfo) {
        switch info {
        case .evasion: dataModel.defender = updatedVision
        case .accuracy: dataModel.attacker = updatedVision
        } 
    }
    
    func showDetails(_ info: StatsContainerInfo, completion: @escaping (Vision) -> Void) -> some View {
        let store = VisionStoreAdapter(store: SharedCoreDataManager.shared, completion: completion)
        let dataModel = makeDataModel(info, store: store)
        
        return VisionDetailsView(dataModel: dataModel)
    }
    
    func makeDataModel(_ info: StatsContainerInfo, store: VisionStore) -> VisionDetailsDataModel {
        switch info {
        case .evasion(let vision):
            return VisionDetailsDataModel(vision: vision, state: .evasion, store: store)
        case .accuracy(let vision):
            return VisionDetailsDataModel(vision: vision, state: .accuracy, store: store)
        }
    }
}


// MARK: - Preview
struct HitRateCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        HitRateCoordinatorView()
    }
}
