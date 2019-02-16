//
//  ChartModel.swift
//  HorizontalGraph
//
//  Created by Yuchen Nie on 2/5/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation
import UIKit

struct ChartModel {
    struct Functions {
        enum Request {
            case WorkoutData
        }
        
        enum Response {
            case WorkoutData(data:[ChartDataTransferModel])
            case Error(chartError:ChartError)
        }
        
        enum State {
            case WorkoutData(workoutViewModels:[ChartViewModel], maxFTP:Float, ftpLine:Float)
            case Error(chartMessage:String)
        }
    }
    
    enum ChartError:Error {
        case UnableToReadData
        case UnableToParseData
    }
    
    struct Dimensions {
        static let Height:CGFloat = UIScreen.main.bounds.height - 20
    }
}

struct ChartDataTransferModel:Codable {
    let type:String
    let start:Int
    let ftp:Float
}
