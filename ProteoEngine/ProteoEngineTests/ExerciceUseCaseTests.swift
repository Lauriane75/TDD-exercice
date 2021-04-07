//
//  SetUseCaseTests.swift
//  ProteoEngineTests
//
//  Created by Christophe Bugnon on 27/03/2021.
//

import XCTest
@testable import ProteoEngine

class ExerciceUseCaseTests: XCTestCase {
    
    func test_start_withZeroSerie_doesNotDisplaySerie() {
        makeSUT(nbOfSeries: 0).start()
        
        XCTAssertNil(output.serieRemainder)
    }
    
    func test_start_withZeroSerie_prepareNextExercice() {
        let sut = makeSUT(nbOfSeries: 0)
        
        sut.start()
        
        XCTAssertEqual(output.result, [])
    }
    
    func test_start_withOneSerie_displayRemainderSerie() {
        makeSUT(nbOfSeries: 1).start()
        
        XCTAssertEqual(output.serieRemainder, 1)
    }
    
    func test_start_withThreeSeriesAndFinishFirstAndSecondSerie_displayRemainderSerie() {
        let sut = makeSUT(nbOfSeries: 3)
        
        sut.start()
        
        output.serieCallback(6)
        output.serieCallback(6)

        XCTAssertEqual(output.serieRemainder, 1)
    }
    
    func test_start_withThreeSerieAndFinishFirstAndSecondAndThirdSeries_DoesNotdisplayAnyOtherSerie() {
        let sut = makeSUT(nbOfSeries: 3)
        
        sut.start()
        
        output.serieCallback(6)
        output.serieCallback(6)
        output.serieCallback(6)

        
        XCTAssertEqual(output.serieRemainder, 1)
    }
    
    func test_start_witOneSerieAndFinishSerie_prepareNextExercice() {
        let sut = makeSUT(nbOfSeries: 1)
        sut.start()
        
        output.serieCallback(6)
        
        XCTAssertEqual(output.result, [6])
    }
    
    func test_start_withTwoSeriesAndFinishFirstAndSecondSerie_preprareNextExercice() {
        let sut = makeSUT(nbOfSeries: 2)
        
        sut.start()
        
        output.serieCallback(6)
        output.serieCallback(5)
        
        XCTAssertEqual(output.result, [6,5])
    }
    
    func test_start_withOneSerieAndDeallocateSUTBeforeFinishRep_DoesNotPrepareNextExercice() {
        var sut: ExerciceUseCase? = makeSUT(nbOfSeries: 2)
        
        sut?.start()
        
        sut = nil
        output.serieCallback(5)
        
        XCTAssertNil(output.result)
        XCTAssertEqual(output.serieRemainder, 2)
    }
    
    func test_start_withTwoSeriesWithoutFinish_doesNotPrepareToNextExercice() {
        let sut = makeSUT(nbOfSeries: 2)
        
        sut.start()
                        
        XCTAssertNil(output.result)
    }
    
    func test_start_withTwoSeriesAndFinishFirstOnly_doesNotPrepareToNextExercice() {
        let sut = makeSUT(nbOfSeries: 2)
        
        output.serieCallback(6)

        sut.start()
                
        XCTAssertNil(output.result)
    }
    
    
    class OutputSpy: ExerciceUseCaseOutput {
        private(set) var serieRemainder: Int?
        private(set) var result: [Int]?
        var serieCallback: ((Int) -> Void) = { _ in}
        
        func displaySerie(remainder: Int, serieCallback: @escaping (Int) -> Void) {
            serieRemainder = remainder
            self.serieCallback = serieCallback
        }
        
        func exerciceFinished(series: [Int]) {
            self.result = series
        }
    }
    
    // MARK: - Helpers
    
    let output = OutputSpy()
    
    private func makeSUT(nbOfSeries: Int) -> ExerciceUseCase {
        return ExerciceUseCase(output: output, nbOfSeries: nbOfSeries)
    }
}
