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
    @Environment(\.dismiss) private var dismiss
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
                if visions.isEmpty {
                    VStack(spacing: 15) {
                        Spacer()
                        Image(systemName: "tray")
                            .font(.largeTitle)
                        Text("No results found")
                            .font(.largeTitle)
                        Text("You haven't saved any units. Tap the button above to add your first unit!")
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                    }.frame(maxWidth: .infinity)
                } else {
                    ForEach(visions) { vision in
                        HStack {
                            HStack {
                                Image(systemName: "checkmark")
                                    .onlyShow(when: vision.id == currentVision.id)
                                Text(vision.name)
                                    .padding()
                                    .font(vision.id == currentVision.id ? .title : .title3)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                currentVision = vision
                                dismiss()
                            }
                                
                            Button(action: { selectedVision = vision }) {
                                Image(systemName: "info.circle")
                                    .font(.title3)
                            }.padding()
                        }
                    }

                }
            }
        }.sheet(item: $selectedVision) { vision in
            NavigationStack {
                // MARK: - TODO
                // enapsulate better
                let store = VisionStoreAdapter(store: SharedCoreDataManager.shared) { updatedVision in
                    /// should be stored in attacker/defender in HitRateDataModel
                    currentVision = updatedVision
                    selectedVision = nil
                }
                let dataModel = VisionDetailsDataModel(vision: vision, state: .allDetails, store: store)
                
                VisionDetailsView(dataModel: dataModel)
                    .navigationTitle(vision.name.isEmpty ? "Add New Vision" : vision.name)
                    .navigationBarTitleDisplayMode(.large)
            }
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


// MARK: - Helpers
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
