//
//  Player.swift
//  OTGTrivia
//
//  Created by Julio Reyes on 4/4/19.
//  Copyright © 2019 Julio Reyes. All rights reserved.
//

import UIKit

class Player: NSObject, NSCoding {
    
    struct Keys{
        static let playerID = "ID"
        static let playerName = "Name"
        static let playerScore = "Score"
        static let difficulty = "Difficulty"
        static let gameType = "Game Type"
        static let correctAnswers = "Correct"
        static let incorrectAnswers = "Incorrect"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_playerID, forKey: Keys.playerID)
        aCoder.encode(_playerName, forKey: Keys.playerName)
        
        aCoder.encode(_playerScore, forKey: Keys.playerScore)
        aCoder.encode(_difficulty, forKey: Keys.difficulty)
        aCoder.encode(_gameType, forKey: Keys.gameType)
        aCoder.encode(_correctAnswers, forKey: Keys.correctAnswers)
        aCoder.encode(_incorrectAnswers, forKey: Keys.incorrectAnswers)
    }
    
    override init() { }
    required init?(coder aDecoder: NSCoder) {
        if let playerIDObj = aDecoder.decodeObject(forKey: Keys.playerID) as? Int {
            _playerID = playerIDObj
        }
        if let playerNameObj = aDecoder.decodeObject(forKey: Keys.playerName) as? String {
            _playerName = playerNameObj
        }
        if let playerScoreObj = aDecoder.decodeObject(forKey: Keys.playerScore) as? Int {
            _playerScore = playerScoreObj
        }
        if let difficultyObj = aDecoder.decodeObject(forKey: Keys.difficulty) as? String {
            _difficulty = difficultyObj
        }
        if let gameTypeObj = aDecoder.decodeObject(forKey: Keys.gameType) as? String {
            _gameType = gameTypeObj
        }
        if let correctAnswersObj = aDecoder.decodeObject(forKey: Keys.correctAnswers) as? Int {
            _correctAnswers = correctAnswersObj
        }
        if let incorrectAnswersObj = aDecoder.decodeObject(forKey: Keys.incorrectAnswers) as? Int {
            _incorrectAnswers = incorrectAnswersObj
        }
    }
    
    private var _playerID: Int = 0
    private var _playerName: String = ""
    private var _playerScore: Int = 0
    private var _difficulty: String  = ""
    private var _gameType: String  = ""
    
    private var _correctAnswers: Int = 0
    private var _incorrectAnswers: Int = 0
    
    init(id: Int, playerName: String, playerScore: Int, difficulty: String,
         gameType: String, correctAnswers: Int, incorrectAnswers: Int) {
        self._playerID = id
        self._playerName = playerName
        self._playerScore = playerScore
        self._difficulty = difficulty
        self._gameType = gameType
        self._correctAnswers = correctAnswers
        self._incorrectAnswers = incorrectAnswers
    }
    
    var playerID: Int {
        get{
            return _playerID
        }set{
            _playerID = newValue
        }
    }
    var playerName: String {
        get{
            return _playerName
        }set{
            _playerName = newValue
        }
    }
    var playerScore: Int {
        get{
            return _playerScore
        }set{
            _playerScore = newValue
        }
    }
    var difficulty: String {
        get{
            return _difficulty
            
        }set{
            _difficulty = newValue
            
        }
    }
    var gameType: String {
        get{
            return _gameType
            
        }set{
            _gameType  = newValue
        }
    }
    
    var correctAnswers: Int  {
        get{
            return _correctAnswers
            
        }set{
            _correctAnswers = newValue
            
        }
    }
    var incorrectAnswers: Int  {
        get{
            return _incorrectAnswers
        }set{
            _incorrectAnswers  = newValue
        }
    }
}
