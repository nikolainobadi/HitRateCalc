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
            // MARK: - TODO
            // need a way to distinguish between attacker and defender
//                .navigationDestination(for: Vision.self, destination: { vision in
//                    UnitListView(currentVision: dataModel.getVisionToReplace(id: vision.id))
//                })
                .sheet(item: $dataModel.selectedInfo) { info in
                    NavigationStack {
                        VisionDetailsView(dataModel: makeDataModel(info, completion: { updatedVision in
                            updateVision(vision: updatedVision, info: info)
                            dataModel.selectedInfo = nil
                        })).navigationTitle(info.title)
                    }
                }
        }
    }
}


// MARK: - Private Methods
private extension HitRateCoordinatorView {
    func updateVision(vision: Vision, info: StatsContainerInfo) {
        switch info {
        case .evasion:
            dataModel.defender = vision
        case .accuracy:
            dataModel.attacker = vision
        } 
    }
    
    func showDetails(_ info: StatsContainerInfo, completion: ((Vision) -> Void)? = nil) -> some View {
        let dataModel = makeDataModel(info, completion: completion)
        
        return VisionDetailsView(dataModel: dataModel)
    }
    
    func makeDataModel(_ info: StatsContainerInfo, completion: ((Vision) -> Void)?) -> VisionDetailsDataModel {
        switch info {
        case .evasion(let vision):
            return VisionDetailsDataModel(vision: vision, state: .evasion, completion: completion ?? { _ in })
        case .accuracy(let vision):
            return VisionDetailsDataModel(vision: vision, state: .accuracy, completion: completion ?? { _ in })
        }
    }
}

struct HitRateCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        HitRateCoordinatorView()
    }
}
