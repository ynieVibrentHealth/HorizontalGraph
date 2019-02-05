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
    var output:ChartViewInput?
    
    func process(_ response: ChartModel.Functions.Response) {
        
    }
}
