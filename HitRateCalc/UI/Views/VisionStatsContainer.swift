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
                        }.frame(maxHeight: getHeightPercent(7))
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
