//
//  SettingsDataModelTests.swift
//  HitRateCalcTests
//
//  Created by Nikolai Nobadi on 1/12/23.
//

import XCTest
@testable import HitRateCalc

final class SettingsDataModelTests: XCTestCase {
    func test_startingValues() {
        let (_, rater) = makeSUT()
        
        XCTAssertFalse(rater.didRateApp)
    }
    
    func test_rateApp() {
        let (sut, rater) = makeSUT()
        
        sut.rateApp()
        
        XCTAssertTrue(rater.didRateApp)
    }
}


// MARK: - SUT
extension SettingsDataModelTests {
    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: SettingsDataModel, rater: MockRater) {
        let rater = MockRater()
        let sut = SettingsDataModel(appRater: rater)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, rater)
    }
}


// MARK: - Helper Classes
extension SettingsDataModelTests {
    class MockRater: AppRater {
        var didRateApp = false
        func rateApp() { didRateApp = true }
    }
}
