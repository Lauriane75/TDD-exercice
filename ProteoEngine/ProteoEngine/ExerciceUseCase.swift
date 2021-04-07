//
//  SetUseCase.swift
//  ProteoEngine
//
//  Created by Christophe Bugnon on 27/03/2021.
//

import Foundation

protocol ExerciceUseCaseOutput {
    func displaySerie(remainder: Int, serieCallback: @escaping (Int) -> Void)
    func exerciceFinished(series: [Int])
}

final class ExerciceUseCase {
    
    private let output: ExerciceUseCaseOutput
    private let nbOfSeries: Int
    private var series = [Int]()
    
    init(output: ExerciceUseCaseOutput, nbOfSeries: Int) {
        self.output = output
        self.nbOfSeries = nbOfSeries
    }
    
    func start() {
        if nbOfSeries > 0 {
            output.displaySerie(remainder: nbOfSeries, serieCallback: nextCallback(nbOfSeries))
        } else {
            output.exerciceFinished(series: series)
        }
    }
    
    func nextCallback(_ serieRemainder: Int) -> (Int) -> Void {
        return { [weak self] in
            self?.displayNext(serieRemainder, repetition: $0)
        }
    }
    
    private func displayNext(_ currentRemainder: Int, repetition: Int) {
        series.append(repetition)
        let nextSerieRemainder = currentRemainder - 1
        if nextSerieRemainder > 0 {
            output.displaySerie(remainder: nextSerieRemainder, serieCallback: nextCallback(nextSerieRemainder))
        } else {
            output.exerciceFinished(series: series)
        }
    }
    
}
