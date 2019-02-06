//
//  ChartViewModel.swift
//  HorizontalGraph
//
//  Created by Yuchen Nie on 2/6/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

struct ChartViewModel {
    let length:Int
    let height:Float
    var displayHeight:Float = 0
    init(length:Int, height:Float) {
        self.length = length
        self.height = height
    }
}
