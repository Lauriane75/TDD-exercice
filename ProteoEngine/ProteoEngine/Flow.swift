//
//  Flow.swift
//  ProteoEngine
//
//  Created by Christophe Bugnon on 25/03/2021.
//

import Foundation

protocol Router {
    associatedtype Exercice: Hashable
    associatedtype Repetition
    func routeToExercice(exercice: Exercice, exerciceCallback: @escaping ([Repetition]) -> Void)
    
    func routeToResult(result: [Exercice: [Repetition]])
}

final class Flow <Exercice, Repetition, R: Router> where R.Exercice == Exercice, R.Repetition == Repetition {
    
    private let exercices: [Exercice]
    private var result: [Exercice: [Repetition]] = [:]
    private let router: R
    
    init(exercices: [Exercice], router: R) {
        self.exercices = exercices
        self.router = router
    }
    
    func start() {
        if let firstExercice = exercices.first {
            router.routeToExercice(exercice: firstExercice,
                                   exerciceCallback: nextCallback(exercice: firstExercice))
        } else {
            // Empty dictionary
            router.routeToResult(result: [:])
        }
    }
    
    private func nextCallback(exercice: Exercice) -> ([Repetition]) -> Void {
        // When Flow is kill we don't want to call routeNext(exercice: String)
        return { [weak self] answer in self?.routeNext(exercice, answer) }
    }
    
    private func routeNext(_ exercice: Exercice, _ answer: [Repetition]) {
        if let currentExerciceIndex = self.exercices.firstIndex(of: exercice) {
            let nextExerciceIndex = currentExerciceIndex+1
            result[exercice] = answer
        
            
            if nextExerciceIndex < self.exercices.count {
                // go to next exercice
                let nextExercice = exercices[nextExerciceIndex]
                router.routeToExercice(exercice: nextExercice, exerciceCallback: nextCallback(exercice: nextExercice))
            } else {
                router.routeToResult(result: result)
            }
        }
    }
    
}
