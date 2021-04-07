//
//  NotifiesPlayerSetStart.swift
//  ProteoEngineTests
//
//  Created by Lau on 02/04/2021.
//

import Foundation
import AVKit

protocol PlayerDelegate {
    func play()
}

final class PlayerSerieStart {
    
    private let prepareSetPlayer: PlayerDelegate
    private let startSetPlayer: PlayerDelegate
    
    init(preparePlayer: PlayerDelegate, startPlayer: PlayerDelegate) {
        self.prepareSetPlayer = preparePlayer
        self.startSetPlayer = startPlayer
    }
    
    func play(time: Int) {
        if time >= 1 && time <= 5 {
            prepareSetPlayer.play()
        }
        if time == 0 {
            startSetPlayer.play()
            
        }
    }
}
