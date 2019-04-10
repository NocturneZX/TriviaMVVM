//
//  APIClientService.swift
//  OTGTrivia
//
//  Created by Julio Reyes on 4/3/19.
//  Copyright © 2019 Julio Reyes. All rights reserved.
//

import UIKit

class APIClientService: NSObject {
    var resultList = Results(responseCode: 0, results: [])
    var settings = GameSettings.sharedInstance
    
    func getQuizResultsData(complete: @escaping DataRetrievalComplete) throws {
        let urlEndpoint = Result.endpointForResults()
        guard URL(string: urlEndpoint) != nil else {
            print( "Something went wrong. No URL processed. On guard.")
            throw NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: nil)
        }
        
        print( "\(settings.amountChosen), \(settings.difficultyChosen),\(settings.gameTypeChosen),")

        var newURL = URLComponents(string: urlEndpoint)
        newURL?.queryItems = [URLQueryItem(name: "amount", value: String(settings.amountChosen)), URLQueryItem(name: "difficulty", value: settings.difficultyChosen), URLQueryItem(name: "type", value: settings.gameTypeChosen)]
        
        print( "\(settings.amountChosen), \(settings.difficultyChosen),\(settings.gameTypeChosen), \(String(describing: newURL?.url))")

        
        // set up the session
        let task = URLSession.shared.resultsTask(with: newURL!.url!) { results, response, error in
            guard let results = results else { print("Error getting data for user"); return }
            self.resultList = results
            complete()
        }
        task.resume()
    }

}
