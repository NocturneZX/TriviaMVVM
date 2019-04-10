//
//  Constants.swift
//  OTGTrivia
//
//  Created by Julio Reyes on 4/4/19.
//  Copyright © 2019 Julio Reyes. All rights reserved.
//

import Foundation
import UIKit


typealias DataRetrievalComplete = () -> ()

var leaderboardFilePath : String {
    let manager = FileManager.default
    let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
    print("URL path in the documentDirectory \(String(describing: url))")
    return (url!.appendingPathComponent("Data").path)
}

// Notification keys
let gotonextQuestion = "kNextQuestionKey"
let answerWasCorrect = "kAnswerCorrectKey"
let correctCheckView = "kCorrectCheckViewKey"
let incorrectCheckView = "kIncorrectCheckViewKey"
let answerWasIncorrect = "kAnswerIncorrectKey"
let quizDone = "kQuizDoneKey"

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
