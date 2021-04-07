//
//  SerieTimerInteractorTests.swift
//  ProteoEngineTests
//
//  Created by Lau on 07/04/2021.
//

import XCTest
@testable import ProteoEngine

class TimerSerieInteractorTests: XCTestCase {

    func test_init_doesNotNotifiesDelegateToStart() {
        let timerSerie = TimerSerie()
        
        let _ = TimerSerieInteractor()
        
        XCTAssertEqual(timerSerie.startCallCount, 0)
    }
    
    class TimerSerie {
        var startCallCount = 0
    }

}
