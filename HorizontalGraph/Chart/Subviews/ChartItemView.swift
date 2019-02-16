//
//  ChartItemView.swift
//  HorizontalGraph
//
//  Created by Yuchen Nie on 2/6/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import UIKit
import SnapKit

class ChartItemView:UIView {
    fileprivate lazy var containerView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        self.addSubview(view)
        return view
    }()
    
    fileprivate lazy var chartItem:UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        self.containerView.addSubview(view)
        return view
    }()
    private var viewModel:ChartViewModel?
    private var width:Int = 0
    
    public func configure(with viewModel:ChartViewModel, maxFTP:Float) {
        width = viewModel.length
        self.viewModel = viewModel
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        containerView.snp.updateConstraints { (make) in
            make.edges.equalTo(self).priority(999)
            make.height.equalTo(ChartModel.Dimensions.Height).priority(999)
            make.width.equalTo(self.width).priority(999)
        }
        
        chartItem.snp.updateConstraints { (make) in
            make.leading.trailing.equalTo(containerView).priority(999)
            if let viewModel = self.viewModel {
                make.height.equalTo(containerView).multipliedBy(viewModel.displayHeight).priority(999)
            }
            make.bottom.equalTo(containerView).priority(999)
        }
        super.updateConstraints()
    }
}
