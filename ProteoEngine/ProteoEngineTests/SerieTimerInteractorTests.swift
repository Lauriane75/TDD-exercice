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
        let _ = TimerSerieInteractor(timer: timerSerie)
        
        XCTAssertEqual(timerSerie.startCallCount, 0)
    }
    
    func test_init_NotifiesDelegateToStart() {
        let timerSerie = TimerSerie()
        let sut = TimerSerieInteractor(timer: timerSerie)
        
        sut.start()
        
        XCTAssertEqual(timerSerie.startCallCount, 1)
    }
    
    class TimerSerie: TimerDelegate {
        var startCallCount = 0

        func start() {
            startCallCount += 1
        }
        
    }

}
