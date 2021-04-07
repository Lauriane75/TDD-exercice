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
        let player = PrepareTrackPlayer()
        let sut = NotifiesPlayerSerieStart(preparePlayer: player)
        
        sut.play(time: 6)
        
        XCTAssertEqual(player.playCallCount, 0)
    }
    
    func test_belowFiveSeconds_triggerPreparePlayer() {
        let player = PrepareTrackPlayer()
        let sut = NotifiesPlayerSerieStart(preparePlayer: player)
        
        sut.play(time: 4)
        
        XCTAssertEqual(player.playCallCount, 1)
    }
    
    class PrepareTrackPlayer: TrackPlayer {
        var playCallCount = 0
        
        func play() {
            playCallCount += 1
        }
    }
    
}
