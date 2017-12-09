//
//  Exercise.swift
//  FitbodExercise
//
//  Created by Stefan Auvergne on 12/8/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation

class Exercise{
    
    var date:String!
    var name:String!
    var sets:String!
    var reps:String!
    var weight:String!
    
    init(date:String, name:String, sets:String, reps:String, weight:String){
        self.date = date
        self.name = name
        self.sets = sets
        self.reps = reps
        self.weight = weight
    }
    
}
