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
        let output = OutputSpy()
        let sut = SetUseCase(output: output, nbOfRepetitions: 0)
        sut.start()
        XCTAssertEqual(output.repetitionCallCount, 0)
    }
    
    func test_start_withOneRepetition_displayRepetition() {
        let output = OutputSpy()
        let sut = SetUseCase(output: output, nbOfRepetitions: 1)
        sut.start()
        XCTAssertEqual(output.repetitionCallCount, 1)
    }
    
    func test_start_withTwoRepetitionsAndFinishFirstRep_displaySecondRepetition() {
        let output = OutputSpy()
        let sut = SetUseCase(output: output, nbOfRepetitions: 2)
        
        sut.start()
        
        output.repetitionCallback(6)
        
        XCTAssertEqual(output.repetitionCallCount, 2)
    }
    
    class OutputSpy: SetUseCaseOutput {
        
        var repetitionCallCount = 0
        
        var repetitionCallback: ((Int) -> Void) = { _ in}
        
        func displayRepetition(remainder: Int, repetitionCallback: @escaping (Int) -> Void) {
            repetitionCallCount += 1
            self.repetitionCallback = repetitionCallback
        }
    }
   
}
