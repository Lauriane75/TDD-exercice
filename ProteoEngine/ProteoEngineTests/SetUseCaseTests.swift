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
    
    class OutputSpy: SetUseCaseOutput {
        var repetitionCallCount = 0
        
        func displayRepetition() {
            repetitionCallCount += 1
        }
    }
   
}
