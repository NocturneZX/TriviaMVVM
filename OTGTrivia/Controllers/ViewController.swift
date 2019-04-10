//
//  ViewController.swift
//  OTGTrivia
//
//  Created by Julio Reyes on 4/3/19.
//  Copyright © 2019 Julio Reyes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var difficultySegmentedControl: UISegmentedControl!
    @IBOutlet weak var numberquestionsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var quiztypeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var quizbeginButton: UIButton!
    
    var difficulty: String = "hard"
    var amount: Int = 10
    var type: String = "boolean"
    
    var settings = GameSettings.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentedControlAction(sender: UISegmentedControl) {
        if sender == self.difficultySegmentedControl{
            UIView.animate(withDuration: 0.2) {
                switch sender.selectedSegmentIndex{
                case 0:
                    self.difficulty = "easy"
                    sender.tintColor = .blue
                case 1:
                    self.difficulty = "medium"
                    sender.tintColor = .green
                default:
                    self.difficulty = "hard"
                    sender.tintColor = .red
                }
            }
        } else if sender == self.numberquestionsSegmentedControl{
            switch sender.selectedSegmentIndex{
            case 0:
                amount = 10
            case 1:
                amount = 20
            case 2:
                amount = 30
            case 3:
                amount = 50
            default:
                amount = 10
            }
        }else{
            switch sender.selectedSegmentIndex{
            case 1:
                type = "multiple"
            default:
                type = "boolean"
            }
        }
        
        
    }
    
    @IBAction func beginGame(sender: UIButton){
        self.present(TriviaPageViewController(),
                     animated: true,
                     completion: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        
        // Declare settings for the user choice of play
        settings.amountChosen = amount
        settings.difficultyChosen = difficulty
        settings.gameTypeChosen = type
    }
    
}

