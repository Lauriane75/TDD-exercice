//
//  TimerSerieInteractor.swift
//  ProteoEngineTests
//
//  Created by Lau on 07/04/2021.
//

import Foundation

protocol TimerDelegate {
    func start()
    func thick(callback: @escaping () -> Void)
}

class TimerSerieInteractor {
    
    let timerDelegate: TimerDelegate
    private var restTime: Int
    
    init(timer: TimerDelegate) {
        self.timerDelegate = timer
        self.restTime = 0
    }
    
    func start(restTime: Int, callback: @escaping (Int) -> Void) {
        self.restTime = restTime
        callback(restTime)
        
        timerDelegate.start()
        
        timerDelegate.thick {
            self.restTime -= 1
            callback(self.restTime)
        }
    }
    
}
