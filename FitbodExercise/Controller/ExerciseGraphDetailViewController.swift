//
//  ExerciseGraphDetailViewController.swift
//  FitbodExercise
//
//  Created by Stefan Auvergne on 12/9/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import Charts

class ExerciseGraphDetailViewController: UIViewController{
    
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var exerciseName: UILabel!
    @IBOutlet weak var exerciseSubtitle: UILabel!
    @IBOutlet weak var exercisePredictedOneRepMax: UILabel!
    
    var lineChartEntry = [ChartDataEntry]()
    var xAxisFormatDelegate: IAxisValueFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xAxisFormatDelegate = self
        let xaxis = chartView.xAxis
        xaxis.valueFormatter = xAxisFormatDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        ExerciseManager.shared.removeAllRelevantExercises()
        
        exerciseName.text = ExerciseManager.shared.passedCellName
        exerciseSubtitle.text = ExerciseManager.shared.passedCellSubtitle
        exercisePredictedOneRepMax.text = ExerciseManager.shared.passedCellTheoreticalOneRepMax
        
        //filter exercises by exercise names
        ExerciseManager.shared.retrieveRelevantExercises()
        
        //reverse array order of exercise from oldest to newest
        ExerciseManager.shared.setRelevantExercises(relevantExercises:ExerciseManager.shared.relevantExercises.reversed())
        
        createChart(exercises: ExerciseManager.shared.relevantExercises)
    }
    
    func createChart(exercises:[Exercise]){
        lineChartEntry.removeAll()
        chartView.chartDescription?.text = ""
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawLabelsEnabled = true
        chartView.xAxis.axisMinimum = 0.0
        chartView.xAxis.axisMaximum = Double(exercises.count+1)
        chartView.xAxis.labelCount = 4
        chartView.legend.enabled = false
        chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        chartView.leftAxis.labelFont = UIFont(name: "Avenir", size: 12)!
        chartView.leftAxis.labelTextColor = UIColor.white
        chartView.rightAxis.labelFont = UIFont(name: "Avenir", size: 12)!
        chartView.rightAxis.labelTextColor = UIColor.white
        chartView.xAxis.labelFont = UIFont(name: "Avenir", size: 10)!
        chartView.xAxis.labelTextColor = UIColor.white
        chartView.backgroundColor = UIColor.black
        
        for x in 0...exercises.count-1{
            let dataEntry = ChartDataEntry(x: Double(x), y: Calculations.calculateTheoreticalOneRepMax(weight: exercises[x].weight, reps: exercises[x].reps))
            lineChartEntry.append(dataEntry)
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Weight")
        line1.setColor(NSUIColor.white)
        line1.circleRadius = 3
        line1.drawCircleHoleEnabled = false
        
        let data = LineChartData()
        data.addDataSet(line1)
        chartView.data = data
        data.setValueFormatter(MyValueFormatter())
    }
}

//xAxisFormatDelegate
extension ExerciseGraphDetailViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return String(describing: ExerciseManager.shared.relevantExercises[Int(value)].date!)
    }
}

class MyValueFormatter:NSObject, IValueFormatter{
    //removes label for each data point
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return ""
    }
}
