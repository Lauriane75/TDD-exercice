//
//  TimerSerieInteractor.swift
//  ProteoEngineTests
//
//  Created by Lau on 07/04/2021.
//

import Foundation

protocol TimerDelegate {
    func start()
    
}

class TimerSerieInteractor {
    
    let timer: TimerDelegate
    
    init(timer: TimerDelegate) {
        self.timer = timer
    }
    
    func start() {
        timer.start()
    }
    
}
