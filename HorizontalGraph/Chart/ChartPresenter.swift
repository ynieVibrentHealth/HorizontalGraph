//
//  ChartPresenter.swift
//  HorizontalGraph
//
//  Created by Yuchen Nie on 2/5/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

protocol ChartPresenterInput {
    func process(_ response:ChartModel.Functions.Response)
}

class ChartPresenter:ChartPresenterInput {
    var output:ChartContainerViewInput?
    
    func process(_ response: ChartModel.Functions.Response) {
        switch response {
        case .Error(let chartError):
            output?.display(.Error(chartError: chartError))
        case .WorkoutData(let data):
            processDataTransferModels(chartDTOs: data)
        }
    }
    
    private func processDataTransferModels(chartDTOs:[ChartDataTransferModel]) {
        var viewModels = [ChartViewModel]()
        var maxFtp:Float = 0
        for (index,dto) in chartDTOs.enumerated() {
            let viewModel:ChartViewModel
            if index == chartDTOs.count - 1 {
                viewModel = ChartViewModel(length: 300, height: dto.ftp)
            } else {
                let nextItem = chartDTOs[index + 1]
                let length = nextItem.start - dto.start 
                viewModel = ChartViewModel(length: length, height: dto.ftp)
            }
            if maxFtp < viewModel.height {
                maxFtp = viewModel.height
            }
            viewModels.append(viewModel)
        }
        let displayModels = viewModels.map { (viewModel) -> ChartViewModel in
            var chartModel = ChartViewModel(length: viewModel.length, height: viewModel.height)
            chartModel.displayHeight = viewModel.height/maxFtp
            return chartModel
        }
        output?.display(.WorkoutData(workoutViewModels: displayModels, maxFTP: maxFtp))
    }
}
