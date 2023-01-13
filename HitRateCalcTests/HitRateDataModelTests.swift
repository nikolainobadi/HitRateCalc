//
//  HitRateDataModelTests.swift
//  HitRateCalcTests
//
//  Created by Nikolai Nobadi on 1/12/23.
//

import XCTest
@testable import HitRateCalc

final class HitRateDataModelTests: XCTestCase {
    func test_startingValues() {
        XCTAssertFalse(makeSUT().checkingHitRate)
    }
    
    func test_toggleMode() {
        let sut = makeSUT()
        
        sut.toggleMode()
        
        XCTAssertTrue(sut.checkingHitRate)
        
        sut.toggleMode()
        
        XCTAssertFalse(sut.checkingHitRate)
    }
    
    func test_finalRateTitle() {
        let sut = makeSUT()
        
        XCTAssertTrue(sut.finalRateTitle.contains("evade"))
        
        sut.toggleMode()
        
        XCTAssertTrue(sut.finalRateTitle.contains("hit"))
    }
    
    func test_evastionRate_emptyTraitsReturnsZero() {
        XCTAssertEqual(makeSUT().evasionRate, 0)
    }
    
    func test_accuracyRate_emptyTraitsReturnsZero() {
        XCTAssertEqual(makeSUT().accuracyRate, 0)
    }
    
    func test_finalRate_emptyValues_checkingHitRate_returnsZero() {
        XCTAssertEqual(makeSUT(checkingHitRate: true).finalRate, "0")
    }
    
    func test_finalRate_emptyValues_checkingHitRateIsFalse_returns100() {
        XCTAssertEqual(makeSUT().finalRate, "100")
    }
    
    func test_evasionRate_onlyEvadeBonus() {
        let traits = makeEvasionTraits(bonus: "100")
        let sut = makeSUT(evasionTraits: traits)
    
        XCTAssertEqual(sut.evasionRate, 100)
    }
    
    func test_accuracyRate_onlyAccuracyBonus() {
        let traits = makeAccuracyTraits(bonus: "100")
        let sut = makeSUT(accuracyTraits: traits)
    
        XCTAssertEqual(sut.accuracyRate, 100)
    }
    
    func test_clearValues() {
        let evasionTraits = makeEvasionTraits(agility: "100", luck: "100", bonus: "100")
        let accuracyTraits = makeAccuracyTraits(dex: "100", luck: "100", bonus: "100")
        let sut = makeSUT(evasionTraits: evasionTraits, accuracyTraits: accuracyTraits)
        
        sut.evasionTraits.forEach { XCTAssertNotEqual($0.amount, "") }
        sut.accuracyTraits.forEach { XCTAssertNotEqual($0.amount, "") }
        
        sut.clearValues(isEvasion: true)
        
        sut.evasionTraits.forEach { XCTAssertEqual($0.amount, "") }
        sut.accuracyTraits.forEach { XCTAssertNotEqual($0.amount, "") }
        
        sut.clearValues(isEvasion: false)
        
        sut.evasionTraits.forEach { XCTAssertEqual($0.amount, "") }
        sut.accuracyTraits.forEach { XCTAssertEqual($0.amount, "") }
    }
}


// MARK: - Formula Tests -> values verified manually first
extension HitRateDataModelTests {
    func test_evasionRate() {
        let traits = makeEvasionTraits(agility: "100", luck: "400", bonus: "50")
        let sut = makeSUT(evasionTraits: traits)
        
        XCTAssertEqual(sut.evasionRate, 177)
    }
    
    func test_accuracyRate() {
        let traits = makeAccuracyTraits(dex: "400", luck: "400", bonus: "50")
        let sut = makeSUT(accuracyTraits: traits)
        
        XCTAssertEqual(sut.accuracyRate, 290)
    }
}


// MARK: - SUT
extension HitRateDataModelTests {
    func makeSUT(checkingHitRate: Bool = false, evasionTraits: [Trait] = Trait.evasionTraits, accuracyTraits: [Trait] = Trait.accuracyTraits, file: StaticString = #filePath, line: UInt = #line) -> HitRateDataModel {
        
        HitRateDataModel(checkingHitRate: checkingHitRate, evasionTraits: evasionTraits, accuracyTraits: accuracyTraits)
    }
    
    func makeEvasionTraits(agility: String = "", luck: String = "", bonus: String = "") -> [Trait] {
        
        [Trait(id: 0, name: "Agility", amount: agility), Trait(id: 1, name: "Luck", amount: luck), Trait(id: 2, name: "Bonus", amount: bonus)]
    }
    
    func makeAccuracyTraits(dex: String = "", luck: String = "", bonus: String = "") -> [Trait] {
        [Trait(id: 0, name: "Dexterity", amount: dex), Trait(id: 1, name: "Luck", amount: luck), Trait(id: 2, name: "Bonus", amount: bonus)]
    }
}
