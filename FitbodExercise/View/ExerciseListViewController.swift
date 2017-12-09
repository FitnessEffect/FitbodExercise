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
                        let tempArr = line.components(separatedBy: ",")
                        let tempExercise = Exercise(date: tempArr[0], name: tempArr[1], sets: tempArr[2], reps: tempArr[3], weight: tempArr[4])
                        
                        //form list of unique exercise names
                        if !uniqueExercises.contains(tempArr[1]){
                            uniqueExercises.append(tempArr[1])
                        }
                        exercises.append(tempExercise)
                    }
                }
            } catch {
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        cell.exercisePredictedOneRepMax.text = "315"
        return cell
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
