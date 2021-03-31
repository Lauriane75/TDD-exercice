//
//  Flow.swift
//  ProteoEngine
//
//  Created by Christophe Bugnon on 25/03/2021.
//

import Foundation

protocol Router {
    func routeToExercice()
}

final class Flow {
    
    private let exercices: [String]
    private let router: Router
    
    
    init(exercices: [String], router: Router) {
        self.exercices = exercices
        self.router = router
    }
    
    func start() {
        if exercices.count > 0 {
            router.routeToExercice()
        }
    }
    
}
