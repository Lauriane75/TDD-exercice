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
        
        XCTAssertNil(output.repetitionRemainder)
    }
    
    func test_start_withThreeRepetition_prepareNextSerie() {
        let sut = makeSUT(nbOfRepetitions: 0)
        
        sut.start()
        
        XCTAssertEqual(output.preprareNextSetCallCount, 1)
    }
    
    func test_start_withOneRepetition_displayRepetition() {
        makeSUT(nbOfRepetitions: 1).start()
        
        XCTAssertEqual(output.repetitionRemainder, 1)
    }
    
    func test_start_withThreeRepetitionsAndFinishFirstAndSecondRep_displayThirdRepetition() {
        let sut = makeSUT(nbOfRepetitions: 3)
        
        sut.start()
        
        output.repetitionCallback(6)
        output.repetitionCallback(6)

        
        XCTAssertEqual(output.repetitionRemainder, 1)
    }
    
    func test_start_withThreeRepetitionsAndFinishFirstAndSecondAndThirdRep_DoesNotdisplayAnyOtherRepetition() {
        let sut = makeSUT(nbOfRepetitions: 3)
        
        sut.start()
        
        output.repetitionCallback(6)
        output.repetitionCallback(6)
        output.repetitionCallback(6)

        
        XCTAssertEqual(output.repetitionRemainder, 1)
    }
    
    class OutputSpy: SetUseCaseOutput {
        
        var repetitionRemainder: Int?
        
        var preprareNextSetCallCount = 0
        
        var repetitionCallback: ((Int) -> Void) = { _ in}
        
        func displayRepetition(remainder: Int, repetitionCallback: @escaping (Int) -> Void) {
            
            repetitionRemainder = remainder
            self.repetitionCallback = repetitionCallback
        }
        
        func prepareNextSerie() {
            preprareNextSetCallCount += 1
        }
    }
    
    // MARK: - Helpers
    
    let output = OutputSpy()
    
    private func makeSUT(nbOfRepetitions: Int) -> SetUseCase {
        return SetUseCase(output: output, nbOfRepetitions: nbOfRepetitions)
    }
}
