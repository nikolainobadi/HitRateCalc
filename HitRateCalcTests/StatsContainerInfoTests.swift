//
//  StatsContainerInfoTests.swift
//  HitRateCalcTests
//
//  Created by Nikolai Nobadi on 4/13/23.
//

import XCTest
@testable import HitRateCalc

final class StatsContainerInfoTests: XCTestCase {
    func test_evasionRate_emptyValues() {
        XCTAssertEqual(makeEvadeSUT().statRate, 0)
    }
    
    func test_evasionRate_onlyEvadeBonus() {
        XCTAssertEqual(makeEvadeSUT(Vision(evasion: 100)).statRate, 100)
    }
    
    func test_accuracyRate_emptyValues() {
        XCTAssertEqual(makeAccuracySUT().statRate, 0)
    }
    
    func test_accuracyRate_onlyAccuracyBonus() {
        XCTAssertEqual(makeAccuracySUT(Vision(accuracy: 100)).statRate, 100)
    }
}


// MARK: - SUT
extension StatsContainerInfoTests {
    func makeEvadeSUT(_ vision: Vision = Vision()) -> StatsContainerInfo {
        return .evasion(vision)
    }
    
    func makeAccuracySUT(_ vision: Vision = Vision()) -> StatsContainerInfo {
        return .accuracy(vision)
    }
}
