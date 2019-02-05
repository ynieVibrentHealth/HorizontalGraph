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
        
    }
}
