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
    
    private func makeSUT(exercices: [String] = []) -> Flow {
        return Flow(exercices: exercices, router: router)
    }
    
    func test_start_withoutExercice_doesNotRouteExercice() {
        
        let flow = makeSUT()
        
        flow.start()
        
        XCTAssertTrue(router.routedExercices.isEmpty)
        
    }

    func test_start_withOneExercice_RouteToCorrectExercice() {
        
        let flow = makeSUT(exercices: ["E1"])
        
        flow.start()
        
        XCTAssertEqual(router.routedExercices, ["E1"])
    }
    
    func test_startTwice_withTwoExercices_RouteToFirstExerciceTwice() {
        
        let flow = makeSUT(exercices: ["E1", "E2"])
        
        flow.start()
        flow.start()
        
        XCTAssertEqual(router.routedExercices, ["E1", "E1"])
    }
    
    func test_start_withOneExerciceAndFinishedFirstExercice_DoesNotRouteTo_NextExercice() {
        
        let flow = makeSUT(exercices: ["E1"])
        
        flow.start()
        
        router.exerciceCallback([10])
        
        XCTAssertEqual(router.routedExercices, ["E1"])
    }
    
    func test_start_withThreeExercicesAndFinishedFirstAndSecondExercice_RouteToThirdExercice() {
        
        let flow = makeSUT(exercices: ["E1", "E2", "E3"])
        
        flow.start()
        
        router.exerciceCallback([8,8,8])
        router.exerciceCallback([8,8,8])

        
        XCTAssertEqual(router.routedExercices, ["E1", "E2", "E3"])
    }
    
    func test_start_withTwoExercicesAndFinishedFirstExerciceAndDeallocateSUT_DoesNotRouteToNextExercice() {
        
        var flow: Flow? = makeSUT(exercices:  ["E1", "E2"])
        
        flow?.start()
        flow = nil
        
        router.exerciceCallback([8,8,8])
        
        XCTAssertEqual(router.routedExercices, ["E1"])
    }
    
}

class RouterSpy: Router {
    
    private(set) var routedExercices = [String]()
    var exerciceCallback: ([Int]) -> Void = { _ in }
    
    func routeToExercice(exercice: String, exerciceCallback: @escaping ([Int]) -> Void) {
        routedExercices.append(exercice)
        self.exerciceCallback = exerciceCallback
    }
    
    
    
}
