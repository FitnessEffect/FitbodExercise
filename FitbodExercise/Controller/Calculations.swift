//
//  Calculations.swift
//  FitbodExercise
//
//  Created by Stefan Auvergne on 12/9/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation

class Calculations{
    
    static func calculateTheoreticalOneRepMax(weight:String, reps:String, completion:@escaping (Float)->Void){
        let result = Double(weight)!*((36/(37-Double(reps)!)))
        completion(Float(result))
    }
    
    static func calculateTheoreticalOneRepMax(weight:String, reps:String)->Double{
        return Double(weight)!*((36/(37-Double(reps)!)))
    }
}
