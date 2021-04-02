//
//  SetUseCase.swift
//  ProteoEngine
//
//  Created by Christophe Bugnon on 27/03/2021.
//

import Foundation

protocol SetUseCaseOutput {
    func displayRepetition(remainder: Int, repetitionCallback: @escaping (Int) -> Void)
}

class SetUseCase {
    
    let output: SetUseCaseOutput
    let nbOfRepetitions: Int
    
    init(output: SetUseCaseOutput, nbOfRepetitions: Int) {
        self.output = output
        self.nbOfRepetitions = nbOfRepetitions
    }
    
    func start() {
        if nbOfRepetitions > 0 {
            output.displayRepetition(remainder: nbOfRepetitions) {
                [unowned self] (_) in output.displayRepetition(remainder: self.nbOfRepetitions) { _ in }
            }
        }
    }
  
}
