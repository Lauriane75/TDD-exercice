//
//  SetUseCaseTests.swift
//  ProteoEngineTests
//
//  Created by Christophe Bugnon on 27/03/2021.
//

import XCTest
@testable import ProteoEngine

class SetUseCaseTests: XCTestCase {
    
    func test_start_withZeroRepetitions_doesNotDisplayRepetition() {
        makeSUT(nbOfRepetitions: 0).start()
        XCTAssertEqual(output.repetitionCallCount, 0)
    }
    
    func test_start_withOneRepetition_displayRepetition() {
        makeSUT(nbOfRepetitions: 1).start()
        XCTAssertEqual(output.repetitionCallCount, 1)
    }
    
    func test_start_withTwoRepetitionsAndFinishFirstRep_displaySecondRepetition() {
        let sut = makeSUT(nbOfRepetitions: 2)
        
        sut.start()
        
        output.repetitionCallback(6)
        
        XCTAssertEqual(output.repetitionCallCount, 2)
    }
    
    func test_start_withThreeRepetitionsAndFinishSecondRep_displayThirdRepetition() {
        let sut = makeSUT(nbOfRepetitions: 3)
        
        sut.start()
        
        output.repetitionCallback(6)
        output.repetitionCallback(6)
        
        XCTAssertEqual(output.repetitionCallCount, 3)
    }
    
    class OutputSpy: SetUseCaseOutput {
        
        var repetitionCallCount = 0
        
        var repetitionCallback: ((Int) -> Void) = { _ in}
        
        func displayRepetition(remainder: Int, repetitionCallback: @escaping (Int) -> Void) {
            repetitionCallCount += 1
            self.repetitionCallback = repetitionCallback
        }
    }
    
    // MARK: - Helpers
    
    let output = OutputSpy()
    
    private func makeSUT(nbOfRepetitions: Int) -> SetUseCase {
        return SetUseCase(output: output, nbOfRepetitions: nbOfRepetitions)
    }
}
