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
        let _ = TimerSerieInteractor(timer: timerSpy)
        
        XCTAssertEqual(timerSpy.startCallCount, 0)
    }
    
    func test_start_NotifiesDelegateToStart() {
        let sut = makeSUT()
        
        sut.start(restTime: 0) { _ in }
        
        XCTAssertEqual(timerSpy.startCallCount, 1)
    }
    
    func test_start_atFourthRestSeconds_decreaseRestTimeToZero() {
        let sut = makeSUT()
        var timerTimes: [Int] = []

        sut.start(restTime: 4) { timerTimes.append($0) }
        
        timerSpy.thickCallBack?()
        timerSpy.thickCallBack?()
        timerSpy.thickCallBack?()
        timerSpy.thickCallBack?()
        
        XCTAssertEqual(timerTimes, [4, 3, 2, 1, 0])
    }
    
    func test_start_atThirdRestSeconds_decreaseRestTimeToZero_TimerDelegateIsStopped() {
        let sut = makeSUT()
        var timerRest: [Int] = []

        sut.start(restTime: 3) { timerRest.append($0) }

        timerSpy.thickCallBack?()
        timerSpy.thickCallBack?()
        timerSpy.thickCallBack?()


        XCTAssertEqual(timerRest, [3, 2, 1, 0])
        XCTAssertEqual(timerSpy.stopCallCount, 1)
    }
    
    func test_start_andDeallocatedSUT_doesNotDecreaseRestTime() {
        var sut: TimerSerieInteractor? = makeSUT()
        var timerRests: [Int] = []

        sut?.start(restTime: 3) { timerRests.append($0) }

        sut = nil
        
        timerSpy.thickCallBack?()

        XCTAssertEqual(timerRests, [3])
    }
    
    // MARK: - Helpers
    
    let timerSpy = TimerSpy()
    
    private func makeSUT() -> TimerSerieInteractor {
        return TimerSerieInteractor(timer: timerSpy)
    }

    class TimerSpy: TimerDelegate {
        var startCallCount = 0
        var stopCallCount = 0
        var thickCallBack: (() -> Void)?
        
        func start() {
            startCallCount += 1
        }
        
        func stop() {
            stopCallCount += 1
        }
        
        func tick(callback: @escaping () -> Void) {
            thickCallBack = callback
        }
    }

}
