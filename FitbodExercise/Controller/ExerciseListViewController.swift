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
    
    var exercises = [Exercise]()
    var uniqueExercises = [String]()
    var exercisePredictedOneRepMaxDictionary = [String:Float]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let url = Bundle.main.url(forResource:"workoutData", withExtension: "txt") {
            do {
                let data = try Data(contentsOf:url)
                let attibutedString = try NSAttributedString(data: data, documentAttributes: nil)
                let fullText = attibutedString.string
                let file = fullText.components(separatedBy: CharacterSet.newlines)
                uniqueExercises.removeAll()
                for line in file {
                    if line != " " && line != ""{
                        let exerciseData = line.components(separatedBy: ",")
                        let tempExercise = Exercise(date: exerciseData[0], name: exerciseData[1], sets: exerciseData[2], reps: exerciseData[3], weight: exerciseData[4])
                        
                        //form list of unique exercise names
                        if !uniqueExercises.contains(exerciseData[1]){
                            uniqueExercises.append(exerciseData[1])
                            exercisePredictedOneRepMaxDictionary[exerciseData[1]] = 0
                        }
                         exercises.append(tempExercise)
                        
                        //Calculate theoretical One Rep Max on seperate thread
                        DispatchQueue.global(qos: .userInitiated).async {
                        
                            Calculations.calculateTheoreticalOneRepMax(weight: exerciseData[4], reps:exerciseData[3], completion: {result in
                                //closure
                                if let value = self.exercisePredictedOneRepMaxDictionary[exerciseData[1]]{
                                    if result > value{
                                        self.exercisePredictedOneRepMaxDictionary[exerciseData[1]] = result
                                    }
                                }
                            })
                        }
                        tableView.reloadData()
                    }
                }
            } catch {
                print(error)
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uniqueExercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! ExerciseTableViewCell
        cell.exerciseName.text = uniqueExercises[indexPath.row]
        cell.exerciseSubtitle.text = "One Rep Max • lbs"
        cell.exercisePredictedOneRepMax.text = String(describing: Int(exercisePredictedOneRepMaxDictionary[uniqueExercises[indexPath.row]]!))
        return cell
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedRow = tableView.indexPathForSelectedRow
        let cell = tableView.cellForRow(at: selectedRow!) as! ExerciseTableViewCell
        
        let exerciseGraphDetailVC:ExerciseGraphDetailViewController = segue.destination as! ExerciseGraphDetailViewController
         exerciseGraphDetailVC.setPassedExercisesInfo(name:cell.exerciseName.text!, subtitle: cell.exerciseSubtitle.text!, predictedOneRepMax:cell.exercisePredictedOneRepMax.text!)
        exerciseGraphDetailVC.setAllExercises(exercises:exercises)
        
    }


}
