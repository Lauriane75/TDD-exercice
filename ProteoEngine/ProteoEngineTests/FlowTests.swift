//
//  FlowTests.swift
//  ProteoEngineTests
//
//  Created by Christophe Bugnon on 25/03/2021.
//

import XCTest
@testable import ProteoEngine

class FlowTests: XCTestCase {
    
    let router = RouterSpy()
    
    // MARK: - Helpers
    
    // sut = System under test = replace with the class you want to test
    private func makeSUT(exercices: [String] = []) -> Flow {
        return Flow(exercices: exercices, router: router)
    }
    
    func test_start_withoutExercice_doesNotRouteExercice() {
        
        makeSUT().start()
        
        XCTAssertTrue(router.routedExercices.isEmpty)
        
    }

    func test_start_withOneExercice_RouteToCorrectExercice() {
                
        makeSUT(exercices: ["E1"]).start()
        
        XCTAssertEqual(router.routedExercices, ["E1"])
    }
    
    func test_startTwice_withTwoExercices_RouteToFirstExerciceTwice() {
        
        let sut = makeSUT(exercices: ["E1", "E2"])
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedExercices, ["E1", "E1"])
    }
    
    func test_start_withOneExerciceAndFinishedFirstExercice_DoesNotRouteTo_NextExercice() {
        
        let sut = makeSUT(exercices: ["E1"])
        
        sut.start()
        
        router.exerciceCallback([10])
        
        XCTAssertEqual(router.routedExercices, ["E1"])
    }
    
    func test_start_withThreeExercicesAndFinishedFirstAndSecondExercice_RouteToThirdExercice() {
        
        let sut = makeSUT(exercices: ["E1", "E2", "E3"])
        
        sut.start()
        
        router.exerciceCallback([8,8,8])
        router.exerciceCallback([8,8,8])

        
        XCTAssertEqual(router.routedExercices, ["E1", "E2", "E3"])
    }
    
    func test_start_withTwoExercicesAndFinishedFirstExerciceAndDeallocateSUT_DoesNotRouteToNextExercice() {
        
        var sut: Flow? = makeSUT(exercices:  ["E1", "E2"])
        
        sut?.start()
        sut = nil
        
        router.exerciceCallback([8,8,8])
        
        XCTAssertEqual(router.routedExercices, ["E1"])
    }
    
    func test_start_withoutExercice_routeToResult() {
        
        let sut = makeSUT()
        
        sut.start()
        
        router.exerciceCallback([8,8,8])
        
        XCTAssertEqual(router.routedResult!, [:])
    }
    
    func test_start_withOneExerciceAndFinishExercice_routeToResult() {
        
        let sut = makeSUT(exercices: ["E1"])
        
        sut.start()

        router.exerciceCallback([2])

        XCTAssertEqual(router.routedResult!, ["E1": [8,8,8]])
    }
    
}

class RouterSpy: Router {
    
    private(set) var routedExercices = [String]()
    private(set) var routedResult: [String: [Int]]? = [:]

    var exerciceCallback: ([Int]) -> Void = { _ in }
    
    func routeToExercice(exercice: String, exerciceCallback: @escaping ([Int]) -> Void) {
        routedExercices.append(exercice)
        self.exerciceCallback = exerciceCallback
    }
    
    func routeToResult(result: [String : [Int]]) {
        routedResult = result
    }
}
