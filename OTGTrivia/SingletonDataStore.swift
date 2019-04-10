//
//  SingletonDataStore.swift
//  OTGTrivia
//
//  Created by Julio Reyes on 4/10/19.
//  Copyright © 2019 Julio Reyes. All rights reserved.
//

import UIKit

class SingletonDataStore {
    static let sharedInstance = SingletonDataStore()
    private init() {
        
    }
    var players: [Player] = []
}
