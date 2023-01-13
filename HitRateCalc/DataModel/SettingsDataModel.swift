//
//  SettingsDataModel.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 1/12/23.
//

import Foundation

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
