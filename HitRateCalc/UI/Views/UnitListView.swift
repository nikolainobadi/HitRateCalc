//
//  UnitListView.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import SwiftUI

struct UnitListView: View {
    @Binding var currentVision: Vision
    @State private var selectedVision: Vision?
    @FetchRequest(fetchRequest: VisionEntity.all()) private var entities: FetchedResults<VisionEntity>
    
    private var visions: [Vision] { entities.map({ Vision(entity: $0) }) }
    
    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    Button("Add New Unit", action: { selectedVision = Vision() })
                        .font(.title3)
                        .buttonStyle(.borderedProminent)
                    Spacer()
                }
            }
            
            Section("Available Units") {
                ForEach(visions) { vision in
                    HStack {
                        Image(systemName: "checkmark")
                            .onlyShow(when: vision.id == currentVision.id)
                        Text(vision.name)
                            .padding()
                            .font(vision.id == currentVision.id ? .title : .title3)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        Spacer()
                        Button(action: { }) {
                            Image(systemName: "info.circle")
                                .font(.title3)
                        }.padding()
                    }
                }
            }
        }.sheet(item: $selectedVision) { vision in
            let dataModel = VisionDetailsDataModel(vision: vision, state: .allDetails) { updatedVision in
                currentVision = updatedVision
            }
            
            VisionDetailsView(dataModel: dataModel)
        }
    }
}


// MARK: - Preview
struct UnitListView_Previews: PreviewProvider {
    static var previews: some View {
        UnitListView(currentVision: .constant(Vision(id: Vision.alayaId)))
            .environment(\.managedObjectContext, SharedCoreDataManager.shared.viewContext)
            .previewDisplayName("UnitList with Data")
            .onAppear { VisionEntity.makePreview(visionList: Vision.defaultList) }
    }
}

extension Vision {
    init(entity: VisionEntity) {
        self.init(id: entity.id ?? UUID(), name: entity.name, luck: entity.luck.toInt, agility: entity.agility.toInt, dexterity: entity.dexterity.toInt, evasion: entity.evasion.toInt, accuracy: entity.accuracy.toInt)
    }
    
    static let alayaId: UUID = UUID()
    
    static let defaultList: [Vision] = [
        Vision(name: "Eliza", luck: 344, agility: 103, dexterity: 630, evasion: 16, accuracy: 128),
        Vision(id: alayaId, name: "Alaya", luck: 333, agility: 104, dexterity: 504, evasion: 28, accuracy: 59),
        Vision(name: "Leela the Bold", luck: 554, agility: 101, dexterity: 500, evasion: 94, accuracy: 75),
        Vision(name: "Joker", luck: 502, agility: 104, dexterity: 447, evasion: 97, accuracy: 59)
    ]
}
