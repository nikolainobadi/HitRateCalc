//
//  VisionStatsContainer.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import SwiftUI

struct VisionStatsContainer: View {
    let viewModel: StatsContainerInfo
    let resetValues: () -> Void
    
    private var canResetValues: Bool { viewModel.statList.map({ $0.amount }).reduce(0, +) != 0 }
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - TODO
            // setUnit will lead to unitList
            StatHeader(title: viewModel.title, action: { })
            
            HStack {
                StatList(statList: viewModel.statList)
                Divider()
                    .background(.primary)
                    .frame(maxHeight: getHeightPercent(21))
                VStack {
                    Spacer()
                    Text("\(viewModel.statRate)%")
                        .lineLimit(1)
                        .font(.largeTitle)
                        .minimumScaleFactor(0.5)
                        .frame(maxWidth: getWidthPercent(25))
                    Spacer()
                    Button("Reset Values", action: resetValues)
                        .underline()
                        .padding()
                        .onlyShow(when: canResetValues)
                }.frame(maxHeight: getHeightPercent(21))
            }.withRoundedBorder()
        }
    }
}


// MARK: - Header
fileprivate struct StatHeader: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            // MARK: - TODO
            // uncomment once UnitList is enabled
//            Button("Set Unit", action: action)
//                .buttonStyle(.bordered)
//                .padding(.horizontal)
//                .padding(.vertical, 8)
        }
    }
}


// MARK: - StatList
fileprivate struct StatList: View {
    let statList: [VisionStat]
     
    var body: some View {
        VStack(spacing: 0) {
            ForEach(statList) { stats in
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
                }.frame(maxHeight: getHeightPercent(7))
            }
        }
    }
}


// MARK: - Preview
struct VisionStatsContainer_Previews: PreviewProvider {
    static var previews: some View {
        VisionStatsContainer(viewModel: .accuracy(Vision()), resetValues: { })
    }
}
