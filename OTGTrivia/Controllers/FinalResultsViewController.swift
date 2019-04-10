//
//  FinalResultsViewController.swift
//  OTGTrivia
//
//  Created by Julio Reyes on 4/8/19.
//  Copyright © 2019 Julio Reyes. All rights reserved.
//

import UIKit

class FinalResultsViewController: UIViewController {

    @IBOutlet weak var correctAnswersLabel: UILabel!
    @IBOutlet weak var incorrectAnswersLabel: UILabel!
    
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var playerNameTextField: UITextField!
    
    var finalScoreData: [String:Any] = [:]
    var store = SingletonDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.correctAnswersLabel.text = "Correct Answers: \(finalScoreData["correct"] ?? "Correct Answers: 0")"
        self.incorrectAnswersLabel.text = "Incorrect Answers: \(finalScoreData["incorrect"] ?? "Incorrect Answers: 0")"
        self.playerScoreLabel.text = "Your Score: \(finalScoreData["score"] ?? "Your Score: 0")"

    }
    

    
    @IBAction func saveData(sender: UIButton){
        if playerNameTextField.text != ""{
            let playerID = Int.random(in: 1000 ..< 9999)
            let playerName = self.playerNameTextField.text!
            let playerScore =  finalScoreData["score"] as! Int
            let difficulty = finalScoreData["difficulty"] as! String
            let gameType = finalScoreData["gametype"] as! String
            let correct =  finalScoreData["correct"] as! Int
            let incorrect = finalScoreData["incorrect"] as! Int
            let player = Player(id: playerID, playerName: playerName, playerScore: playerScore, difficulty: difficulty , gameType: gameType , correctAnswers: correct , incorrectAnswers: incorrect)
            self.store.players.append(player)
            // NSKeyedArchiver encodes player data and save it to file path.
            // Archive object to save data to filepath url
            NSKeyedArchiver.archiveRootObject(self.store.players, toFile: leaderboardFilePath)
            
            // Post Alert.
            
            sender.isEnabled = false
        }

    }
    @IBAction func playAgain(sender: UIButton){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
