//
//  ChartInteractor.swift
//  HorizontalGraph
//
//  Created by Yuchen Nie on 2/5/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

protocol ChartInteractorInput {
    func handle(_ request:ChartModel.Functions.Request)
}

class ChartInteractor:ChartInteractorInput {
    internal var output:ChartPresenterInput?
    
    func handle(_ request: ChartModel.Functions.Request) {
        switch request {
        case .WorkoutData:
            retrieveWorkoutData()
        }
    }
    
    private func retrieveWorkoutData() {
        guard let path = Bundle.main.path(forResource: "WorkoutData", ofType: "json") else {unableToRetriveDataError();return}
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let items = try decoder.decode([ChartDataTransferModel].self, from: data)
            output?.process(.WorkoutData(data: items))
        } catch {
            unableToRetriveDataError()
        }
    }
    
    private func unableToRetriveDataError() {
        output?.process(.Error(chartError: .UnableToReadData))
    }
}
