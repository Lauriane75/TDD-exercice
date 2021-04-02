//
//  FlowTests.swift
//  ProteoEngineTests
//
//  Created by Christophe Bugnon on 25/03/2021.
//

import XCTest
@testable import ProteoEngine

class FlowTests: XCTestCase {
        
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
        
        router.setCallBack([10])
        
        XCTAssertEqual(router.routedExercices, ["E1"])
    }
    
    func test_start_withThreeExercicesAndFinishedFirstAndSecondExercice_RouteToThirdExercice() {
        
        let sut = makeSUT(exercices: ["E1", "E2", "E3"])
        
        sut.start()
        
        router.setCallBack([8,8,8])
        router.setCallBack([8,8,8])

        
        XCTAssertEqual(router.routedExercices, ["E1", "E2", "E3"])
    }
    
    func test_start_withTwoExercicesAndFinishedFirstExerciceAndDeallocateSUT_DoesNotRouteToNextExercice() {
        
        var sut: Flow? = makeSUT(exercices:  ["E1", "E2"])
        
        sut?.start()
        sut = nil
        
        router.setCallBack([8,8,8])
        
        XCTAssertEqual(router.routedExercices, ["E1"])
    }
    
    func test_start_withoutExercice_routeToResult() {
        
        makeSUT().start()
        
//        why calling the callback here ?
        router.setCallBack([8,8,8])
        
        XCTAssertEqual(router.routedResult, [:])
    }
    
    func test_start_withOneExerciceAndFinishExercice_routeToResult() {
        
        let sut = makeSUT(exercices: ["E1"])
        
        sut.start()

        router.setCallBack([8,8,8])

        XCTAssertEqual(router.routedResult, ["E1": [8,8,8]])
    }
    
    func test_start_withTwoExercicesAndFinishFirstAndSecondExercice_routeToResult() {
        
        let sut = makeSUT(exercices: ["E1","E2"])
        
        sut.start()

        router.setCallBack([8,8,8])
        router.setCallBack([6,6,6,6])

        XCTAssertEqual(router.routedResult, ["E1": [8,8,8], "E2": [6,6,6,6]])
    }
    
    func test_start_withOneExercices_DoesNotRouteToResult() {
        
        makeSUT(exercices: ["E1"]).start()

        XCTAssertNil(router.routedResult)
    }
    
    func test_start_withTwoExercices_AndFinishFirstExercice_DoesNotRouteToResult() {
        
        makeSUT(exercices: ["E1","E2"]).start()
        
        router.setCallBack([8,8,8])

        XCTAssertNil(router.routedResult)
    }
    
    class RouterSpy: Router {
        
        private(set) var routedExercices = [String]()
        private(set) var routedResult: [String: [Int]]?

        var setCallBack: ([Int]) -> Void = { _ in }
        
        func routeToExercice(exercice: String, setCallback: @escaping ([Int]) -> Void) {
            routedExercices.append(exercice)
            self.setCallBack = setCallback
        }
        
        func routeToResult(result: [String : [Int]]) {
            routedResult = result
        }
    }
    
    // MARK: - Helpers
    
    let router = RouterSpy()
    
    private func makeSUT(exercices: [String] = []) -> Flow<String, Int, RouterSpy> {
        return Flow(exercices: exercices, router: router)
    }
    
}


