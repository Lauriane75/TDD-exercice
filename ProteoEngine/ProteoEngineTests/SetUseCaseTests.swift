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
        
        XCTAssertEqual(output.result, [])
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
    
    func test_start_withOneRepetitionsAndDeallocateSUTBeforeFinishRep_DoesNotPrepareNextExercice() {
        var sut: SetUseCase? = makeSUT(nbOfRepetitions: 2)
        
        sut?.start()
        
        sut = nil
        output.repetitionCallback(5)
        
        XCTAssertNil(output.result)
    }
    
    func test_start_withTwoRepetitionsAndFinishFirstAndSecondRep_preprareNextExercice() {
        let sut = makeSUT(nbOfRepetitions: 2)
        
        sut.start()
        
        output.repetitionCallback(6)
        output.repetitionCallback(5)
        
        XCTAssertEqual(output.result, [6,5])
    }
    
    func test_start_withOneRepetitionsAndFinishRepetition_preprareNextSerie() {
        let sut = makeSUT(nbOfRepetitions: 1)
        
        sut.start()
        
        output.repetitionCallback(6)
        
        XCTAssertEqual(output.result, [6])
    }
    
    class OutputSpy: SetUseCaseOutput {
        
        private(set) var repetitionRemainder: Int?
        private(set) var result: [Int]?
        var repetitionCallback: ((Int) -> Void) = { _ in}
        
        func displayRepetition(remainder: Int, repetitionCallback: @escaping (Int) -> Void) {
            
            repetitionRemainder = remainder
            self.repetitionCallback = repetitionCallback
        }
        
        func prepareNextSerie(result: [Int]) {
            self.result = result
        }
    }
    
    // MARK: - Helpers
    
    let output = OutputSpy()
    
    private func makeSUT(nbOfRepetitions: Int) -> SetUseCase {
        return SetUseCase(output: output, nbOfRepetitions: nbOfRepetitions)
    }
}
