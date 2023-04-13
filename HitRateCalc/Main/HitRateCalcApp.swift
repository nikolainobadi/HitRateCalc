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
    var body: some Scene {
        WindowGroup {
            HitRateCoordinatorView()
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

