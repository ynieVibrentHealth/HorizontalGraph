//
//  ChartView.swift
//  HorizontalGraph
//
//  Created by Yuchen Nie on 2/5/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol ChartContainerViewInput {
    func display(_ state:ChartModel.Functions.State)
}

class ChartContainerView:UIViewController {
    internal var output:ChartInteractorInput?
    
    fileprivate lazy var scrollContainer:UIScrollView = {
        let scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.backgroundColor = .white
        scrollView.alwaysBounceVertical = false
        self.view.addSubview(scrollView)
        return scrollView
    }()
    
    fileprivate lazy var stackContainer:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        self.scrollContainer.addSubview(stackView)
        return stackView
    }()
    
    override func viewWillLayoutSubviews() {
        scrollContainer.snp.updateConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        stackContainer.snp.updateConstraints { (make) in
            make.edges.equalTo(self.scrollContainer)
            make.height.equalTo(UIScreen.main.bounds.height)
        }
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        output?.handle(.WorkoutData)
        edgesForExtendedLayout = []
    }
}

extension ChartContainerView:ChartContainerViewInput {
    func display(_ state: ChartModel.Functions.State) {
        DispatchQueue.main.async { [weak self] in
            switch state {
            case .Error(let chartError):
                print("error:\(chartError)")
            case let .WorkoutData(workoutViewModels, maxFTP):
                self?.layoutGraph(with: workoutViewModels, and: maxFTP)
            }
        }
    }
    
    private func layoutGraph(with chartViewModels:[ChartViewModel], and maxFTP:Float) {
        for chartViewModel in chartViewModels {
            let chartItemView = ChartItemView()
            chartItemView.configure(with: chartViewModel, maxFTP: maxFTP)
            stackContainer.addArrangedSubview(chartItemView)
        }
    }
}
