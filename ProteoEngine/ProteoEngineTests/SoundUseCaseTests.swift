//
//  SoundUseCaseTests.swift
//  ProteoEngineTests
//
//  Created by Lau on 02/04/2021.
//

import XCTest
import AVKit

@testable import ProteoEngine

class SoundUseCaseTests: XCTestCase {
    
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
    
    class PrepareTrackPlayer: TrackPlayer {
        var playCallCount = 0
        
        func play() {
            playCallCount += 1
        }
    }
    
    class StartTrackPlayer: TrackPlayer {
        var playCallCount = 0
        
        func play() {
            playCallCount += 1
        }
    }
    
    let preparePlayer = PrepareTrackPlayer()
    let startPlayer = StartTrackPlayer()

    private func makeSUT() -> NotifiesPlayerSerieStart {
        return NotifiesPlayerSerieStart(preparePlayer: preparePlayer, startPlayer: startPlayer)
    }
    
}
