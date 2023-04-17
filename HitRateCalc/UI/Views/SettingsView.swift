//
//  SettingsView.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 1/12/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var dataModel = SettingsDataModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Divider().background(.primary).padding(1)
                AboutText().padding(.vertical, 10)
                Spacer()
                FormulaLink()
                Spacer()
                ButtonView()
                    .padding(.top, 10)
                    .padding(.horizontal)
                Spacer()
                Text(dataModel.disclaimer)
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .minimumScaleFactor(0.6)
                Link(destination: URL(string: dataModel.privacyPolicyURL)!) {
                    Text("Privacy Policy")
                        .underline()
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                        .foregroundColor(.primary)
                }
            }
            .environmentObject(dataModel)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(isSmallPhone ? .inline : .large)
            .toolbar {
                Button(action: { dismiss() }) {
                    Text("Done")
                        .tint(.primary)
                }
            }
        }
    }
}

// MARK: - About
fileprivate struct AboutText: View {
    @EnvironmentObject var dataModel: SettingsDataModel
    
    var body: some View {
        Text(dataModel.aboutText)
            .padding(.horizontal, 10)
            .minimumScaleFactor(0.5)
    }
}


// MARK: - Link
fileprivate struct FormulaLink: View {
    @EnvironmentObject var dataModel: SettingsDataModel
    
    var body: some View {
        Link(destination: URL(string: dataModel.youtubeURL)!) {
            Text("WOTV Evasion and Accuracy explained!")
                .underline()
                .lineLimit(1)
                .minimumScaleFactor(0.6)
                .foregroundColor(.primary)
        }
    }
}


// MARK: - Buttons
fileprivate struct ButtonView: View {
    @EnvironmentObject var dataModel: SettingsDataModel
    
    var body: some View {
        VStack {
            if isSmallPhone {
                HStack(spacing: getWidthPercent(20)) {
                    Link(destination: URL(string: dataModel.emailURL)!) {
                        Text("Feedback?").lineLimit(1).minimumScaleFactor(0.6)
                    }.buttonStyle(.borderedProminent)
                    
                    Button(action: dataModel.rateApp) {
                        Text("Rate App")
                            .lineLimit(1).minimumScaleFactor(0.6)
                    }.buttonStyle(.borderedProminent)
                }
            } else {
                VStack(spacing: getHeightPercent(5)) {
                    Link(destination: URL(string: dataModel.emailURL)!) {
                        Text("Feedback?")
                            .frame(width: getWidthPercent(50))
                    }.buttonStyle(.borderedProminent)
                    
                    Button(action: dataModel.rateApp) {
                        Text("Rate App")
                            .frame(width: getWidthPercent(50))
                    }.buttonStyle(.borderedProminent)
                }
            }
        }
        .tint(.primary)
        .foregroundColor(Color(uiColor: .systemBackground))
        .font(.title3.weight(.semibold))
    }
}


// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
