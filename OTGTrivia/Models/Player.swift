//
//  Player.swift
//  OTGTrivia
//
//  Created by Julio Reyes on 4/4/19.
//  Copyright © 2019 Julio Reyes. All rights reserved.
//

import UIKit

class Player: NSObject, Codable {
    var playerID: Int
    var playerName: String
    var playerScore: Int
    var difficulty: String
    var gameType: String
    
    var correctAnswers: Int
    var incorrectAnswers: Int
    
    init(id: Int, playerName: String, playerScore: Int, difficulty: String,
         gameType: String, correctAnswers: Int, incorrectAnswers: Int) {
        self.playerID = id
        self.playerName = playerName
        self.playerScore = playerScore
        self.difficulty = difficulty
        self.gameType = gameType
        self.correctAnswers = correctAnswers
        self.incorrectAnswers = incorrectAnswers
    }
}
