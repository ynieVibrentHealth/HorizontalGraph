//
//  ChartConfigurator.swift
//  HorizontalGraph
//
//  Created by Yuchen Nie on 2/5/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

class ChartConfigurator {
    static let instance:ChartConfigurator = ChartConfigurator()
    private init(){}
    
    func configure(with view:ChartContainerView) {
        let interactor = ChartInteractor()
        let presenter = ChartPresenter()
        
        view.output = interactor
        interactor.output = presenter
        presenter.output = view
    }
}
