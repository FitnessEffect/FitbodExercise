//
//  ExerciseManager.swift
//  FitbodExercise
//
//  Created by Stefan Auvergne on 12/9/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation

class ExerciseManager{
    
    static let shared = ExerciseManager()
    
    private var _exercises = [Exercise]() //all exercises from list
    private var _uniqueExerciseNames = [String]() //single occurance of each exercise name
    private var _relevantExercises = [Exercise]() //sorted exercise list by exercise name
    private var _passedCellName = String()
    private var _passedCellSubtitle = String()
    private var _passedCellTheoreticalOneRepMax = String()
    
    func retrieveRelevantExercises(){
        for exercise in _exercises{
            if exercise.name == _passedCellName{
                _relevantExercises.append(exercise)
            }
        }
    }
    
    func appendExerciseToExercises(exercise:Exercise){
        _exercises.append(exercise)
    }
    
    func appendExerciseNameToUniqueExerciseNames(exerciseName:String){
        _uniqueExerciseNames.append(exerciseName)
    }
    
    func removeAllUniqueExercises(){
        _uniqueExerciseNames.removeAll()
    }
    
    func removeAllRelevantExercises(){
        _relevantExercises.removeAll()
    }
    
    var passedCellName:String{
        get{
            return _passedCellName
        }
        set(newCellName) {
            _passedCellName = newCellName
        }
    }
    
    var passedCellSubtitle:String{
        get{
            return _passedCellSubtitle
        }
        set(newCellSubtitle){
            _passedCellSubtitle = newCellSubtitle
        }
    }
    
    var passedCellTheoreticalOneRepMax:String{
        get{
            return _passedCellTheoreticalOneRepMax
        }
        set(newCellTheoreticalOneRepMax){
            _passedCellTheoreticalOneRepMax = newCellTheoreticalOneRepMax
        }
    }
    
    var exercises:[Exercise]{
        get{
            return _exercises
        }
    }
    
    var uniqueExerciseNames:[String]{
        get{
            return _uniqueExerciseNames
        }
    }
    
    var relevantExercises:[Exercise]{
        get{
            return _relevantExercises
        }
        set(newRelevantExercises){
            _relevantExercises = newRelevantExercises
        }
    }
}
