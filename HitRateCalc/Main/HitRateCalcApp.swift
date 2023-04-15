//
//  HitRateCalcApp.swift
//  HitRateCalc
//
//  Created by Nikolai Nobadi on 1/12/23.
//

import SwiftUI

@main
struct AppLauncher {
    static func main() throws {
        if NSClassFromString("XCTestCase") == nil {
            HitRateCalcApp.main()
        } else {
            TestApp.main()
        }
    }
}

struct HitRateCalcApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @AppStorage(AppStorageKey.initialLaunch) var isInitialLaunch = true
    
    var body: some Scene {
        WindowGroup {
            LaunchCoordinatorView(isInitialLaunch: $isInitialLaunch)
                .environment(\.managedObjectContext, SharedCoreDataManager.shared.viewContext)
        }.onChange(of: scenePhase) { phase in
            if phase == .active {
                if !isInitialLaunch {
                    AppOpenAdManager.shared.showAdIfAvailable()
                }
            }
        }
    }
}

struct TestApp: App {
    var body: some Scene {
        WindowGroup {
            Text("Running Unit Tests")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black)
        }
    }
}

enum AppStorageKey {
    static let initialLaunch = "INITIAL_LAUNCH"
}
