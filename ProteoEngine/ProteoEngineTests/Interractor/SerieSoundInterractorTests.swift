//
//  SerieSoundInterractorTests.swift
//  ProteoEngineTests
//
//  Created by Lau on 02/04/2021.
//


import XCTest
@testable import ProteoEngine

class SerieSoundInterractorTests: XCTestCase {
    
    func test_aboveFiveSeconds_doesNotTriggerPreparePlayer() {
        let sut = makeSUT()

        sut.play(time: 6)
        
        XCTAssertEqual(preparePlayer.playCallCount, 0)
    }
    
    func test_atFiveSeconds_triggerPreparePlayer() {
        let sut = makeSUT()
        
        sut.play(time: 5)
        sut.play(time: 4)
        
        XCTAssertEqual(preparePlayer.playCallCount, 2)
    }
    
    func test_atZeroSecond_triggerStartPlayer() {
        let sut = makeSUT()
        
        sut.play(time: 0)
        
        XCTAssertEqual(preparePlayer.playCallCount, 0)
        XCTAssertEqual(startPlayer.playCallCount, 1)
    }
    
    func test_playAboveZeroSecond_doesnottriggerStartPlayer() {
        let sut = makeSUT()
        
        sut.play(time: 1)
        
        XCTAssertEqual(startPlayer.playCallCount, 0)
    }
    
    // MARK: - Helpers
    
    class PrepareTrackPlayerSpy: PlayerDelegate {
        var playCallCount = 0
        
        func play() {
            playCallCount += 1
        }
    }
    
    class StartTrackPlayerSpy: PlayerDelegate {
        var playCallCount = 0
        
        func play() {
            playCallCount += 1
        }
    }
    
    let preparePlayer = PrepareTrackPlayerSpy()
    let startPlayer = StartTrackPlayerSpy()

    private func makeSUT() -> SerieSoundInterractor {
        return SerieSoundInterractor(preparePlayer: preparePlayer, startPlayer: startPlayer)
    }
    
}
