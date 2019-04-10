//
//  ResultsViewModel.swift
//  OTGTrivia
//
//  Created by Julio Reyes on 4/3/19.
//  Copyright © 2019 Julio Reyes. All rights reserved.
//

import Foundation
import UIKit

class ResultsViewModel: NSObject {
    
    var setDifficulty: String = "hard"
    var setAmount = 10
    var setQuizType = "boolean"
    
    var apiClient: APIClientService!
    var quizList: [Result] = []
    
    var isLoading: Bool = false {
        didSet{
            self.loadingStatus?()
        }
    }
    var loadingStatus: (()->())?

    
    var correctAnswersHit: Int = 0
    var incorrectAnswersHit: Int = 0
    
    
//    var questionPages: [UIViewController] = []
//    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController
//    {
//        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
//    }
    
    override init() {
        super.init()
        self.apiClient = APIClientService()
        NotificationCenter.default.addObserver(self, selector: #selector(updateResultsCorrect), name: NSNotification.Name(answerWasCorrect), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateResultsIncorrect), name: NSNotification.Name(answerWasIncorrect), object: nil)
        
    }
    
    
    func getQuiz(complete: @escaping DataRetrievalComplete){
        self.isLoading = true
        try! self.apiClient.getQuizResultsData(){
            self.isLoading = false
            self.quizList = self.apiClient.resultList.results
            complete()
        }
    }
    
//    func setUpPages(){
//        for question in self.quizList{
//            guard let questionPageInstance = self.getViewController(withIdentifier: "QuestionViewController") as? QuestionViewController else{
//                return
//            }
//            questionPageInstance.currentQuizQuestion = question
//            self.questionPages.append(questionPageInstance)
//        }
//    }
    
    
    @objc func updateResultsCorrect(){
        self.correctAnswersHit += 1
    }
    
    @objc func updateResultsIncorrect(){
        self.incorrectAnswersHit += 1
    }
    
    func rcleanViewModel(){
        self.correctAnswersHit = 0
        self.incorrectAnswersHit = 0
        self.setDifficulty = "hard"
        self.setAmount = 10
        self.setQuizType = "boolean"
        self.quizList = []
    }
        
}
extension ResultsViewModel {
    func getQuestions(from result: Result) -> String{
        return result.question
    }
    
    func getCorrectAnswer(from result: Result) -> String{
        return result.correctAnswer
    }
    
    func getGameType(from result: Result) -> String{
        return result.type.description()
    }
    
    func getDifficulty(from result: Result) -> String{
        return result.difficulty.description()
    }
    
    func getAmountOfQuestions() -> Int{
        return quizList.count
    }

}
