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
    
    init(preparePlayer: TrackPlayer) {
        self.preparePlayer = preparePlayer
    }
    
    func play(time: Int) {
        if time <= 5 {
            preparePlayer.play()
        }
    }
}
