//
//  FitbodExerciseTests.swift
//  FitbodExerciseTests
//
//  Created by Stefan Auvergne on 12/8/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import XCTest
@testable import FitbodExercise

class FitbodExerciseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCalculateTheoreticalOneRepMax(){
        let result = FitbodExercise.Calculations.calculateTheoreticalOneRepMax(weight:"135", reps:"10")
        let expectedResult:Double = 180
        
        let result2 = FitbodExercise.Calculations.calculateTheoreticalOneRepMax(weight: "285", reps: "5")
        let expectedResult2:Double = 320.625
        
        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(result2, expectedResult2)
    }
    
}
