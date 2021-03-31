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
                
                if let previewsExerciceIndex = exercices.firstIndex(of: firstExercice) {
                    let nextExerciceIndex = previewsExerciceIndex+1
                    if nextExerciceIndex < exercices.count {
                        router.routeToExercice(exercice: exercices[nextExerciceIndex], exerciceCallback: { _ in })
                    }
                }
            }
        }
    }
    
}
