//
//  TestHelper.swift
//  HorizontalGraphTests
//
//  Created by Yuchen Nie on 2/16/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

class TestHelper {
    private init(){}
    
    static func readJSONObject(from file:String) -> Data? {
        let bundle = Bundle(for: self)
        guard let url = bundle.url(forResource: file, withExtension: "json"),
            let jsonData = try? Data(contentsOf:url) else {return nil}
        return jsonData
    }
    
    static func roundNumberToTwoDigits(number:Float) -> Float{
        return Float(round(100*number)/100)
    }
}
