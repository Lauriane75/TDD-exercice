//
//  Flow.swift
//  ProteoEngine
//
//  Created by Christophe Bugnon on 25/03/2021.
//

import Foundation

protocol Router {
    func routeToExercice(exercice: String, exerciceCallback: @escaping ([Int]) -> Void)
}

final class Flow {
    
    private let exercices: [String]
    private let router: Router
    
    init(exercices: [String], router: Router) {
        self.exercices = exercices
        self.router = router
    }
    
    func start() {
        if let firstExercice = exercices.first {
            router.routeToExercice(exercice: firstExercice,
                                   exerciceCallback: nextCallback(exercice: firstExercice))
        }
    }
    
    private func nextCallback(exercice: String) -> ([Int]) -> Void {
        return { [unowned self] _ in routeNext(exercice: exercice) }
    }
    
    private func routeNext(exercice: String) {
        if let currentExerciceIndex = self.exercices.firstIndex(of: exercice) {
            let nextExerciceIndex = currentExerciceIndex+1
            
            if nextExerciceIndex < self.exercices.count {
                // go to next exercice
                let nextExercice = exercices[nextExerciceIndex]
                router.routeToExercice(exercice: nextExercice, exerciceCallback: nextCallback(exercice: nextExercice))
            }
        }
    }
    
}
