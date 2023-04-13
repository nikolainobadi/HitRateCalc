//
//  VisionStatsContainer.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import SwiftUI

struct VisionStatsContainer: View {
    let viewModel: StatsType
    
    var body: some View {
        VStack(spacing: 0) {
            Text(viewModel.title)
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            HStack {
                VStack(spacing: 0) {
                    ForEach(viewModel.statList) { stats in
                        HStack {
                            Text(stats.name)
                                .lineLimit(1)
                                .font(.title3.weight(.heavy))
                                .minimumScaleFactor(0.5)
                                .foregroundColor(Color(uiColor: .systemBackground))
                                .padding(.horizontal, 5)
                                .frame(maxWidth: getWidthPercent(25), maxHeight: .infinity, alignment: .center)
                                .background(Color(uiColor: .label))
                            
                            TextField("0", text: .constant(stats.value))
                                .font(.title)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .background(Color(uiColor: .secondarySystemBackground))
                                .cornerRadius(10)
                                .padding(10)
                                .disabled(true)
                        }
                    }
                }
                Divider().frame(maxHeight: getHeightPercent(21)).background(.primary)
                VStack {
                    // MARK: - TODO
                    // decide whether or not to include this button
//                    Button(action: { }) {
//                        Text("Clear values")
//                            .underline()
//                            .font(.caption)
//                    }.padding(5)
                    Spacer()
                    Text("\(viewModel.statRate)%")
                        .lineLimit(1)
                        .font(.largeTitle)
                        .minimumScaleFactor(0.5)
                        .frame(maxWidth: getWidthPercent(25))
                    Spacer()
                }.frame(maxHeight: getHeightPercent(21))
            }.withRoundedBorder()
        }
    }
}


// MARK: - Preview
struct VisionStatsContainer_Previews: PreviewProvider {
    static var previews: some View {
        VisionStatsContainer(viewModel: .accuracy(Vision()))
    }
}


// MARK: - Dependencies
enum StatsType {
    case evasion(Vision)
    case accuracy(Vision)
}

extension StatsType {
    var title: String {
        switch self {
        case .evasion: return "Evasion"
        case .accuracy: return "Accuracy"
        }
    }
    
    var statList: [VisionStat] {
        switch self {
        case .evasion(let vision): return vision.evadeStats
        case .accuracy(let vision): return vision.accuracyStats
        }
    }
    
    var statRate: Int {
        switch self {
        case .evasion(let vision):
            return HitRateCalculator.getAccuracyRate(for: vision)
        case .accuracy(let vision):
            return HitRateCalculator.getAccuracyRate(for: vision)
        }
    }
}

struct VisionStat: Identifiable {
    let name: String
    let amount: Int
    
    var id: String { name }
    var value: String { "\(amount)" }
}

extension Vision {
    var evadeStats: [VisionStat] {
        [
            VisionStat(name: "Luck", amount: luck),
            VisionStat(name: "Agility", amount: agility),
            VisionStat(name: "Evade", amount: evasion)
        ]
    }
    
    var accuracyStats: [VisionStat] {
        [
            VisionStat(name: "Luck", amount: luck),
            VisionStat(name: "Dexterity", amount: dexterity),
            VisionStat(name: "Accuracy", amount: accuracy)
        ]
    }
}