//
//  SetUseCase.swift
//  ProteoEngine
//
//  Created by Christophe Bugnon on 27/03/2021.
//

import Foundation

protocol SetUseCaseOutput {
    func displayRepetition(remainder: Int, repetitionCallback: @escaping (Int) -> Void)
    func prepareNextSerie()
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
            output.displayRepetition(remainder: nbOfRepetitions, repetitionCallback: nextCallback(nbOfRepetitions))
        } else {
            output.prepareNextSerie()
        }
    }
    
    func nextCallback(_ repetitionRemainder: Int) -> (Int) -> Void {
        return { [unowned self] _ in
            let nextRepetitionRemainder = repetitionRemainder - 1
            if nextRepetitionRemainder > 0 {
                print("repetitionRemainder = \(repetitionRemainder)")
                self.output.displayRepetition(remainder: nextRepetitionRemainder, repetitionCallback: self.nextCallback(nextRepetitionRemainder))
            }
        }
    }
}
