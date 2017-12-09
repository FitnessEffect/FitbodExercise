//
//  ExerciseGraphDetailViewController.swift
//  FitbodExercise
//
//  Created by Stefan Auvergne on 12/9/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import Charts

class ExerciseGraphDetailViewController: UIViewController {
    
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var exerciseName: UILabel!
    @IBOutlet weak var exerciseSubtitle: UILabel!
    @IBOutlet weak var exercisePredictedOneRepMax: UILabel!
    
    var exercises = [Exercise]()
    var relevantExercises = [Exercise]()
    var displayExerciseName:String!
    var displayExerciseSubtitle:String!
    var displayExercisePredictedOneRepMax:String!
    var lineChartEntry = [ChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exerciseName.text = displayExerciseName
        exerciseSubtitle.text = displayExerciseSubtitle
        exercisePredictedOneRepMax.text = displayExercisePredictedOneRepMax
        
        //filter exercises by exercise names
        retrieveRelevantExercises()
        
        //reverse array order of exercise from oldest to newest
        relevantExercises = relevantExercises.reversed()
        
        createChart(exercises: relevantExercises)
    }
    
    func retrieveRelevantExercises(){
        for exercise in exercises{
            if exercise.name == exerciseName.text{
                relevantExercises.append(exercise)
            }
        }
    }
    
    func createChart(exercises:[Exercise]){
        lineChartEntry.removeAll()
        chartView.chartDescription?.text = ""
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawLabelsEnabled = true
        chartView.xAxis.axisMinimum = 0.0
        chartView.xAxis.axisMaximum = Double(exercises.count+1)
        chartView.xAxis.labelCount = 10
        chartView.legend.enabled = false
        chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        chartView.leftAxis.labelFont = UIFont(name: "Avenir", size: 15)!
        chartView.leftAxis.labelTextColor = UIColor.white
        chartView.rightAxis.labelFont = UIFont(name: "Avenir", size: 15)!
        chartView.rightAxis.labelTextColor = UIColor.white
        chartView.xAxis.labelFont = UIFont(name: "Avenir", size: 15)!
        chartView.xAxis.labelTextColor = UIColor.white
        chartView.backgroundColor = UIColor.black
        
        for x in 0...exercises.count-1{
            let dataEntry = ChartDataEntry(x: Double(x), y: Double(exercises[x].weight)!)
            lineChartEntry.append(dataEntry)
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Weight")
        line1.setColor(NSUIColor.white)
        line1.circleRadius = 3
        line1.drawCircleHoleEnabled = false
        
        let data = LineChartData()
        data.addDataSet(line1)
    
        chartView.data = data
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
