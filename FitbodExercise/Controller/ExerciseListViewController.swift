//
//  ExerciseListViewController.swift
//  FitbodExercise
//
//  Created by Stefan Auvergne on 12/9/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class ExerciseListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var exercisePredictedOneRepMaxDictionary = [String:Float]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        //retrieve exercises from workoutData file
        if let url = Bundle.main.url(forResource:"workoutDataTest", withExtension: "txt") {
            do {
                let data = try Data(contentsOf:url)
                let attibutedString = try NSAttributedString(data: data, documentAttributes: nil)
                let fullText = attibutedString.string
                let file = fullText.components(separatedBy: CharacterSet.newlines)
                ExerciseManager.shared.removeAllUniqueExercises()
                for line in file {
                    //reads each line from file and skips empty lines
                    if line != " " && line != ""{
                        let exerciseData = line.components(separatedBy: ",")
                        let tempExercise = Exercise(date: exerciseData[0], name: exerciseData[1], sets: exerciseData[2], reps: exerciseData[3], weight: exerciseData[4])
                        
                        //form list of unique exercise names
                        if !ExerciseManager.shared.uniqueExerciseNames.contains(exerciseData[1]){
                            ExerciseManager.shared.appendExerciseNameToUniqueExerciseNames(exerciseName: exerciseData[1])
                            //initialize predictedOneRepMax to 0
                            exercisePredictedOneRepMaxDictionary[exerciseData[1]] = 0
                        }
                        
                        ExerciseManager.shared.appendExerciseToExercises(exercise: tempExercise)
                        //exercises.append(tempExercise)
                        
                        //Calculate theoretical One Rep Max on seperate thread to free up UI
                        DispatchQueue.global(qos: .userInitiated).async {
                            
                            Calculations.calculateTheoreticalOneRepMax(weight: exerciseData[4], reps:exerciseData[3], completion: {result in
                                //closure
                                if let value = self.exercisePredictedOneRepMaxDictionary[exerciseData[1]]{
                                    if result > value{
                                        self.exercisePredictedOneRepMaxDictionary[exerciseData[1]] = result
                                    }
                                }
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            })
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //clears selection when navigating back
        if tableView.indexPathForSelectedRow != nil{
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ExerciseManager.shared.uniqueExerciseNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! ExerciseTableViewCell
        cell.exerciseName.text = ExerciseManager.shared.uniqueExerciseNames[indexPath.row]
        cell.exerciseSubtitle.text = "One Rep Max • lbs"
        cell.exercisePredictedOneRepMax.text = String(describing: Int(exercisePredictedOneRepMaxDictionary[ExerciseManager.shared.uniqueExerciseNames[indexPath.row]]!))
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedRow = tableView.indexPathForSelectedRow
        let cell = tableView.cellForRow(at: selectedRow!) as! ExerciseTableViewCell
        ExerciseManager.shared.setPassedCellName(cellName: cell.exerciseName.text!)
        ExerciseManager.shared.setPassedCellSubtitle(cellSubtitle: cell.exerciseSubtitle.text!)
        ExerciseManager.shared.setPassedCellTheoreticalOneRepMax(cellTheoreticalOneRepMax: cell.exercisePredictedOneRepMax.text!)
    }
}
