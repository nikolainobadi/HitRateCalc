//
//  UnitListView.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import SwiftUI

struct UnitListView: View {
    let visions: [Vision]
    
    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    Button("Add New Unit", action: { })
                        .font(.title3)
                        .buttonStyle(.borderedProminent)
                    Spacer()
                }
            }
            
            Section("Available Units") {
                ForEach(visions) { vision in
                    HStack {
                        Text(vision.name)
                            .padding()
                            .font(.title)
                        Spacer()
                        Image(systemName: "info.circle")
                    }
                }
            }
        }
    }
}


// MARK: - Preview
struct UnitListView_Previews: PreviewProvider {
    static var previews: some View {
        UnitListView(visions: Vision.defaultList)
    }
}

extension Vision {
    static let defaultList: [Vision] = [
        Vision(name: "Eliza", luck: 344, agility: 103, dexterity: 630, evasion: 16, accuracy: 128),
        Vision(name: "Alaya", luck: 333, agility: 104, dexterity: 504, evasion: 28, accuracy: 59),
        Vision(name: "Bold Leela", luck: 554, agility: 101, dexterity: 500, evasion: 94, accuracy: 75),
        Vision(name: "Joker", luck: 502, agility: 104, dexterity: 447, evasion: 97, accuracy: 59)
    ]
}
