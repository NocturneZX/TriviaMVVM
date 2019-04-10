//
//  GameSettings.swift
//  OTGTrivia
//
//  Created by Julio Reyes on 4/10/19.
//  Copyright © 2019 Julio Reyes. All rights reserved.
//

import UIKit

class GameSettings {
    static let sharedInstance = GameSettings()
    private init() {
        
    }
    var amountChosen: Int = 0
    var difficultyChosen: String = ""
    var gameTypeChosen: String = ""
}
