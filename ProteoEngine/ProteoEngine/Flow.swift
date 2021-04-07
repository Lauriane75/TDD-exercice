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
    func routeToExercice(exercice: Exercice, setCallback: @escaping ([Repetition]) -> Void)
    
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
                                   setCallback: nextCallback(exercice: firstExercice))
        } else {
            // Empty dictionary
            router.routeToResult(result: result)
        }
    }
    
    private func nextCallback(exercice: Exercice) -> ([Repetition]) -> Void {
        // [weak self] = When Flow is killed we don't want to call routeNext(exercice: String)
        return { [weak self] in self?.routeNext(exercice, $0)
            print("repetition : \($0)")
        }
    }
    
    private func routeNext(_ exercice: Exercice, _ repetition: [Repetition]) {
        if let currentExerciceIndex = self.exercices.firstIndex(of: exercice) {
            let nextExerciceIndex = currentExerciceIndex+1
            result[exercice] = repetition
//            If there is an other exercice then
            if nextExerciceIndex < self.exercices.count {
                // go to next exercice
                let nextExercice = exercices[nextExerciceIndex]
                router.routeToExercice(exercice: nextExercice, setCallback: nextCallback(exercice: nextExercice))
//            If it was the last exercice
            } else {
                router.routeToResult(result: result)
            }
        }
    }
}
