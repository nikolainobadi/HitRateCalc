//
//  VisionStatsContainer.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import SwiftUI

struct VisionStatsContainer: View {
    let viewModel: StatsContainerInfo
    
    var body: some View {
        VStack(spacing: 0) {
            StatHeader(title: viewModel.title, action: { })
            
            HStack {
                StatList(statList: viewModel.statList)
                Divider()
                    .background(.primary)
                    .frame(maxHeight: getHeightPercent(21))
                StatRate(statRate: viewModel.statRate)
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
            
            Button("Set Unit", action: action)
                .buttonStyle(.bordered)
                .padding(.horizontal)
                .padding(.vertical, 8)
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


// MARK: - StatRate
fileprivate struct StatRate: View {
    let statRate: Int
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(statRate)%")
                .lineLimit(1)
                .font(.largeTitle)
                .minimumScaleFactor(0.5)
                .frame(maxWidth: getWidthPercent(25))
            Spacer()
        }.frame(maxHeight: getHeightPercent(21))
    }
}


// MARK: - Preview
struct VisionStatsContainer_Previews: PreviewProvider {
    static var previews: some View {
        VisionStatsContainer(viewModel: .accuracy(Vision()))
    }
}
