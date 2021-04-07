//
//  NotifiesPlayerSetStart.swift
//  ProteoEngineTests
//
//  Created by Lau on 02/04/2021.
//

import Foundation
import AVKit


protocol TrackPlayer {
    func play()
}

class NotifiesPlayerSerieStart {
    
    let preparePlayer: TrackPlayer
    let startPlayer: TrackPlayer
    
    init(preparePlayer: TrackPlayer, startPlayer: TrackPlayer) {
        self.preparePlayer = preparePlayer
        self.startPlayer = startPlayer
    }
    
    func play(time: Int) {
        if time >= 1 && time <= 5 {
            preparePlayer.play()
        }
        if time == 0 {
            startPlayer.play()
            
        }
    }
}
