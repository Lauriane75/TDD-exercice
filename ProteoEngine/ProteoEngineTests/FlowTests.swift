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
    
    func test_start_withoutExercice_doesNotRouteExercice() {
        
        let flow = Flow(exercices: [], router: router)
        
        flow.start()
        
        XCTAssertTrue(router.exercices.isEmpty)
        
    }

    func test_start_withOneExercice_RouteToCorrectExercice() {
        
        let flow = Flow(exercices: ["E1"], router: router)
        
        flow.start()
        
        XCTAssertEqual(router.exercices, ["E1"])
    }

    
}

class RouterSpy: Router {
    
    private(set) var exercices = [String]()
    
    func routeToExercice(exercice: String) {
        exercices.append(exercice)
    }
    
}
