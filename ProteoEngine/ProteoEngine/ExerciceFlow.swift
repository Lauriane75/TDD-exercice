//
//  SetUseCase.swift
//  ProteoEngine
//
//  Created by Christophe Bugnon on 27/03/2021.
//

import Foundation

protocol ExerciceFlowDelegate {
    func displaySerie(remainder: Int, serieCallback: @escaping (Int) -> Void)
    func exerciceFinished(series: [Int])
}

final class ExerciceFlow {
    
    private let exerciceFlowDelegate: ExerciceFlowDelegate
    private let nbOfSeries: Int
    private var series = [Int]()
    
    init(output: ExerciceFlowDelegate, nbOfSeries: Int) {
        self.exerciceFlowDelegate = output
        self.nbOfSeries = nbOfSeries
    }
    
    func start() {
        if nbOfSeries > 0 {
            exerciceFlowDelegate.displaySerie(remainder: nbOfSeries, serieCallback: nextCallback(nbOfSeries))
        } else {
            exerciceFlowDelegate.exerciceFinished(series: series)
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
            exerciceFlowDelegate.displaySerie(remainder: nextSerieRemainder, serieCallback: nextCallback(nextSerieRemainder))
        } else {
            exerciceFlowDelegate.exerciceFinished(series: series)
        }
    }
    
}
