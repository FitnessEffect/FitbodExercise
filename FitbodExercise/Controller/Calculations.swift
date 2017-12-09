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
    
    static func retrieveRelevantExercises(name:String, exercises:[Exercise])->[Exercise]{
        var relevantExercises = [Exercise]()
        for exercise in exercises{
            if exercise.name == name{
                relevantExercises.append(exercise)
            }
        }
        return relevantExercises
    }
}
