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


final class SettingsDataModel: ObservableObject {
    private let appRater: AppRater
    
    init(appRater: AppRater = AppRatingManager()) {
        self.appRater = appRater
    }
}


// MARK: - ViewModel
extension SettingsDataModel {
    var emailURL: String { "mailto:hitratecalcapp@gmail.com" }
    var youtubeURL: String { "https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjs3NW4ger5AhVgC0QIHQHoCBwQwqsBegQIAhAB&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DNamgdMLYpMI&usg=AOvVaw0Rss7ODbkU4EEuq7aK-0tw" }
    
    var disclaimer: String {
        "*This is a reference app for informational purposes and meant to assist fans of this game. It is unofficial and not affiliated with the game's developer, publisher or distributor. All information presented can be obtained from free resources on the internet. If you have concerns or feel there is a direct copyright or trademark violation that does not fall within \'fair use\' guidlines, please use the \'Feedback?\' button to email me directly to discuss it.*"
    }
    
    var aboutText: String {
        """
        The Evasion/Accuracy/Hit rate calculator that WoTV players deserve.
        
        Formulas used in this app are derived from the information provided in the video link below!
        
        (NOTE: I have no direct affiliation with the creator of that video, but I'm very thankful for the information.)
        """
    }
    
    func rateApp() {
        appRater.rateApp()
    }
}


// MARK: - Dependencies
protocol AppRater {
    func rateApp()
}

import StoreKit

final class AppRatingManager: AppRater {
    func rateApp() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}
