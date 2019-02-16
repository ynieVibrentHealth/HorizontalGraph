//
//  HorizontalGraphTests.swift
//  HorizontalGraphTests
//
//  Created by Yuchen Nie on 2/5/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//
import Foundation
import XCTest
import Quick
import Nimble

@testable import HorizontalGraph

class HorizontalGraphTests: QuickSpec {
    var mockInteractor:MockInteractor?
    var mockView:MockView?
    var presenter:ChartPresenter?
    

    
    override func spec() {
        describe("Testing Presenter") {
            mockInteractor = MockInteractor()
            mockView = MockView()
            presenter = ChartPresenter()
            mockInteractor?.output = presenter
            presenter?.output = mockView
            
            context("Load chart view Models", {
                self.mockInteractor?.handle(.WorkoutData)
                guard let mockViewModels = self.mockView?.workoutViewModels else {fail("Unable to load view models"); return}
                it("Should load view models", closure: {
                    expect(mockViewModels.count == 60).to(beTrue())
                    guard let firstModel = mockViewModels.first else {fail("Unable to retrieve first view model");return}
                    expect(firstModel.length == 111).to(beTrue())
                    expect(firstModel.height == 0.5).to(beTrue())
                    expect(TestHelper.roundNumberToTwoDigits(number: firstModel.displayHeight) == 0.33).to(beTrue())
                })
            })
            
            context("Load Max FTP", {
                self.mockInteractor?.handle(.WorkoutData)
                guard let maxFTP = self.mockView?.maxFTP else {fail("Unable to load maxFTP"); return}
                it("Should load max ftp", closure: {
                    expect(TestHelper.roundNumberToTwoDigits(number: maxFTP) == 1.5).to(beTrue())
                })
            })
        }
    }
    
    class MockInteractor:ChartInteractorInput {
        var output:ChartPresenterInput?
        
        func handle(_ request: ChartModel.Functions.Request) {
            switch request {
            case .WorkoutData:
                loadSampleData()
            }
        }
        
        private func loadSampleData() {
            
            guard let data = TestHelper.readJSONObject(from: "SampleData") else {unableToRetriveDataError();return}
            do {
                let decoder = JSONDecoder()
                let items = try decoder.decode([ChartDataTransferModel].self, from: data)
                output?.process(.WorkoutData(data: items))
            } catch {
                unableToRetriveDataError()
            }
        }
        
        private func unableToRetriveDataError () {
            fail("Unable to read sample json data")
        }
    }
    
    class MockView:ChartContainerViewInput {
        var errorMessage:String?
        var workoutViewModels:[ChartViewModel]?
        var maxFTP:Float?
        var ftpLineHeight:Float?
        func display(_ state: ChartModel.Functions.State) {
            switch state {
            case .Error(let chartMessage):
                self.errorMessage = chartMessage
                
            case let .WorkoutData(workoutViewModels, maxFTP, ftpLineHeight):
                self.workoutViewModels = workoutViewModels
                self.maxFTP = maxFTP
                self.ftpLineHeight = ftpLineHeight
            }
        }
    }
}
