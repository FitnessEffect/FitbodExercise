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
    
    private var _exercises = [Exercise]()
    private var _uniqueExerciseNames = [String]()
    private var _passedCellName = String()
    private var _passedCellSubtitle = String()
    private var _passedCellTheoreticalOneRepMax = String()
    
    private init(){
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
    
    func setPassedCellName(cellName:String){
        _passedCellName = cellName
    }
    
    func setPassedCellSubtitle(cellSubtitle:String){
        _passedCellSubtitle = cellSubtitle
    }
    
    func setPassedCellTheoreticalOneRepMax(cellTheoreticalOneRepMax:String){
        _passedCellTheoreticalOneRepMax = cellTheoreticalOneRepMax
    }
    
    var passedCellName:String{
        get{
            return _passedCellName
        }
    }
    
    var passedCellSubtitle:String{
        get{
            return _passedCellSubtitle
        }
    }
    
    var passedCellTheoreticalOneRepMax:String{
        get{
            return _passedCellTheoreticalOneRepMax
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
    
}
