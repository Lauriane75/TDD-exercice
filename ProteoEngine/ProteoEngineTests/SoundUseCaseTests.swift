//
//  SoundUseCaseTests.swift
//  ProteoEngineTests
//
//  Created by Lau on 02/04/2021.
//

import XCTest
@testable import ProteoEngine

class SoundUseCaseTests: XCTestCase {
    
    func test_aboveFiveSeconds_doesNotTriggerPlayer() {
        let sut = NotifiesPlayerSerieStart()
        let player = PrepareTrackPlayer()
        
        sut.play()
        
        XCTAssertEqual(player.playCallCount, 0)
        
    }
    
    class PrepareTrackPlayer {
        var playCallCount = 0
        
        func play() {
            
        }
    }
    
}
