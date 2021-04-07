//
//  NotifiesPlayerSetStart.swift
//  ProteoEngineTests
//
//  Created by Lau on 02/04/2021.
//

import Foundation
import AVKit


protocol Player {
    func play()
}

final class NotifiesPlayerSerieStart {
    
    private let prepareSetPlayer: Player
    private let startSetPlayer: Player
    
    init(preparePlayer: Player, startPlayer: Player) {
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
