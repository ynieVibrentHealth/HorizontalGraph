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

protocol ChartViewInput {
    func display(_ state:ChartModel.Functions.State)
}

class ChartView:UIViewController {
    internal var output:ChartInteractorInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        
    }
}

extension ChartView:ChartViewInput {
    func display(_ state: ChartModel.Functions.State) {
        
    }
}
