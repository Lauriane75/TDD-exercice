//
//  TimerSerieInteractor.swift
//  ProteoEngineTests
//
//  Created by Lau on 07/04/2021.
//

import Foundation

protocol TimerDelegate {
    func start()
    func stop()
    func tick(callback: @escaping () -> Void)
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
        
        timerDelegate.tick { [weak self] in
            guard let self = self else { return }
            self.restTime -= 1
            callback(self.restTime)
            
            if self.restTime == 0 {
                self.timerDelegate.stop()
            }
        }
    }
    
}
