//
//  SetUseCase.swift
//  ProteoEngine
//
//  Created by Christophe Bugnon on 27/03/2021.
//

import Foundation

protocol ExerciceUseCaseOutput {
    func displayRepetition(remainder: Int, repetitionCallback: @escaping (Int) -> Void)
    func prepareNextSerie(result: [Int])
}

final class ExerciceUseCase {
    
    private let output: ExerciceUseCaseOutput
    private let nbOfRepetitions: Int
    private var result = [Int]()
    
    init(output: ExerciceUseCaseOutput, nbOfRepetitions: Int) {
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
        return { [weak self] in
            self?.displayNext(repetitionRemainder, repetition: $0)
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
