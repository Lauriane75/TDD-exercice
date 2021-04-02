//
//  SetUseCase.swift
//  ProteoEngine
//
//  Created by Christophe Bugnon on 27/03/2021.
//

import Foundation

protocol ExerciceUseCaseOutput {
    func displaySerie(remainder: Int, repetitionCallback: @escaping (Int) -> Void)
    func exerciceFinished(result: [Int])
}

final class ExerciceUseCase {
    
    private let output: ExerciceUseCaseOutput
    private let nbOfSeries: Int
    private var result = [Int]()
    
    init(output: ExerciceUseCaseOutput, nbOfSeries: Int) {
        self.output = output
        self.nbOfSeries = nbOfSeries
    }
    
    func start() {
        if nbOfSeries > 0 {
            output.displaySerie(remainder: nbOfSeries, repetitionCallback: nextCallback(nbOfSeries))
        } else {
            output.exerciceFinished(result: result)
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
            output.displaySerie(remainder: nextRepetitionRemainder, repetitionCallback: nextCallback(nextRepetitionRemainder))
        } else {
            output.exerciceFinished(result: result)
        }
    }
    
}
