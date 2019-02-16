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
    private var ftpLineHeight:CGFloat = 0
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
    
    fileprivate lazy var ftpLine:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        self.view.addSubview(view)
        return view
    }()
    
    fileprivate lazy var ftpLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 8)
        label.textColor = UIColor.lightGray
        label.text = "FTP"
        self.view.addSubview(label)
        return label
    }()
    
    fileprivate lazy var errorLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Unable to load data"
        self.view.addSubview(label)
        label.isHidden = true
        return label
    }()
    
    override func viewWillLayoutSubviews() {
        scrollContainer.snp.updateConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        stackContainer.snp.updateConstraints { (make) in
            make.leading.trailing.equalTo(self.scrollContainer)
            make.top.bottom.equalTo(self.scrollContainer).inset(10)
            make.height.equalTo(ChartModel.Dimensions.Height)
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
                self?.showError(with: chartError)
            case let .WorkoutData(workoutViewModels, maxFTP, ftpLineHeight):
                self?.layoutGraph(with: workoutViewModels, and: maxFTP)
                self?.addFTPLine(with: ftpLineHeight)
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
    
    private func addFTPLine(with ftpLineHeight:Float) {
        ftpLine.snp.updateConstraints { (make) in
            make.leading.trailing.equalTo(self.view)
            make.bottom.equalTo(self.view).inset(ftpLineHeight)
            make.height.equalTo(1.0)
        }
        
        ftpLabel.snp.updateConstraints { (make) in
            make.bottom.equalTo(ftpLine.snp.top).offset(-2)
            make.leading.equalTo(self.view).inset(5)
        }
        view.bringSubviewToFront(ftpLine)
        view.bringSubviewToFront(ftpLabel)
    }
    
    private func showError(with errorMessage:String) {
        errorLabel.text = errorMessage
        errorLabel.isHidden = false
        errorLabel.snp
            .updateConstraints { (make) in
                make.center.equalTo(self.view)
                make.leading.trailing.equalTo(self.view).inset(30)
        }
    }
}
