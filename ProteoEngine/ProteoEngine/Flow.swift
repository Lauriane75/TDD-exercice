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
            router.routeToExercice(exercice: firstExercice) { [unowned self] _ in
                let exerciceIndex = exercices.firstIndex(of: firstExercice)!
                let nextExercice = exercices[exerciceIndex+1]
                router.routeToExercice(exercice: nextExercice, exerciceCallback: { _ in
                })
            }
        }
    }
    
}
