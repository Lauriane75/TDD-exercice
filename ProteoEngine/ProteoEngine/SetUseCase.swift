//
//  SetUseCase.swift
//  ProteoEngine
//
//  Created by Christophe Bugnon on 27/03/2021.
//

import Foundation

protocol SetUseCaseOutput {
    func displayRepetition(remainder: Int, repetitionCallback: @escaping (Int) -> Void)
    func prepareNextSerie(result: [Int])
}

class SetUseCase {
    
    let output: SetUseCaseOutput
    let nbOfRepetitions: Int
    var result = [Int]()
    
    init(output: SetUseCaseOutput, nbOfRepetitions: Int) {
        self.output = output
        self.nbOfRepetitions = nbOfRepetitions
    }
    
    func start() {
        if nbOfRepetitions > 0 {
            output.displayRepetition(remainder: nbOfRepetitions, repetitionCallback: nextCallback(nbOfRepetitions))
        } else {
            output.prepareNextSerie(result: result)
        }
    }
    
    func nextCallback(_ repetitionRemainder: Int) -> (Int) -> Void {
        return { [unowned self] repetition in
            self.displayNext(repetitionRemainder, repetition: repetition)
        }
    }
    
    private func displayNext(_ currentRemainder: Int, repetition: Int) {
        let nextRepetitionRemainder = currentRemainder - 1
        result.append(repetition)
        if nextRepetitionRemainder > 0 {
            output.displayRepetition(remainder: nextRepetitionRemainder, repetitionCallback: nextCallback(nextRepetitionRemainder))
        } else {
            output.prepareNextSerie(result: result)
        }
    }
    
}
