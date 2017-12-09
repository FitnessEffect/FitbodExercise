//
//  ExerciseGraphDetailViewController.swift
//  FitbodExercise
//
//  Created by Stefan Auvergne on 12/9/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class ExerciseGraphDetailViewController: UIViewController {

    @IBOutlet weak var exerciseName: UILabel!
    @IBOutlet weak var exerciseSubtitle: UILabel!
    @IBOutlet weak var exercisePredictedOneRepMax: UILabel!
    
    var exercises = [Exercise]()
    var displayExerciseName:String!
    var displayExerciseSubtitle:String!
    var displayExercisePredictedOneRepMax:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        exerciseName.text = displayExerciseName
        exerciseSubtitle.text = displayExerciseSubtitle
        exercisePredictedOneRepMax.text = displayExercisePredictedOneRepMax
    }

    
    func setPassedExercisesInfo(name:String, subtitle:String, predictedOneRepMax:String){
        self.displayExerciseName = name
        self.displayExerciseSubtitle = subtitle
        self.displayExercisePredictedOneRepMax = predictedOneRepMax
    }
    
    func setAllExercises(exercises:[Exercise]){
        self.exercises = exercises
    }

}
