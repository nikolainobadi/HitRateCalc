# HitRateCalc
HitRateCalc is an iOS app that helps players of the mobile game Final Fantasy Brave Exvius: War of the Visions determine the accuracy and evasion rates of their units. The app allows users to input dexterity, luck, and accuracy bonus values to calculate accuracy, and agility, luck, and evade bonus values to calculate evasion. The app then combines the two rates to display the final hitrate, or the chance of evading an attack. This app is a useful tool for players looking to optimize their unit's performance in battle.

## Architecure
HitRateCalc was built using SwiftUI (iOS 16 minimun deployment) and uses an 'MVVM' design pattern. The app consists of 4 primary modules:

#### Main
Just contains the entrance to the app.

#### UI
Contains all SwiftUI views as well as any ViewModifiers and extensions to View.

#### DataModel
This is what I call my 'View Models'. `HitRateDataModel` acts as a viewmodel for the main view (`ContentView`), and the `SettingsDataModel` is for `SettingsView`. 

#### Logic
The star file of this app is `HitRateCalculator`. It is responsible for performing the calculations to determine accuracy/evasion rates. The logic used was derived from [this YouTube Video](https://www.youtube.com/watch?v=NamgdMLYpMI).

(NOTE: I have no affiliation with its creator, though I have to say I enjoy the content contained on that channel.)


## Disclaimer
HitRateCalc is not affiliated with or endorsed by Square Enix or gumi Inc. Final Fantasy Brave Exvius: War of the Visions is a registered trademark of Square Enix.

## Contributions
Any contributions from the community is certainly welcome. If you have any features or bug fixes to suggest, please submit a pull request.

## Screenshots

## Download
HitRateCalc is available for download on the AppStore.

## License
HitRateCalc is licensed under the MIT License.
