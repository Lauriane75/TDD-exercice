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
        
        XCTAssertEqual(router.routeToExerciceCallCount, 0)
        
    }
    
}

private class RouterSpy: Router {
    
    var routeToExerciceCallCount = 0

    func routeToExercice() {
        routeToExerciceCallCount += 1
    }
    
}
