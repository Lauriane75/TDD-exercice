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

final class TimerSerieInteractor {
    
    private let timerDelegate: TimerDelegate
    private var restTime: Int
    
    init(timer: TimerDelegate) {
        self.timerDelegate = timer
        self.restTime = 0
    }
    
    func start(restTime: Int, callback: @escaping (Int) -> Void) {
        self.restTime = restTime
        callback(restTime)
        
        timerDelegate.start()
        
        timerDelegate.tick { [weak self] in self?.tick(callback) }
    }
    
    private func tick(_ callback: @escaping (Int) -> Void) {
        restTime -= 1
        callback(restTime)
        if restTime == 0 {
            timerDelegate.stop()
        }
    }
    
}
