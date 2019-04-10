//
//  QuestionViewController.swift
//  OTGTrivia
//
//  Created by Julio Reyes on 4/4/19.
//  Copyright © 2019 Julio Reyes. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerCollectionView: UICollectionView!
    
    private let reuseIdentifier = "QuestionViewCellIdentifier"
    
    var currentQuizQuestion: Result = Result(category: "", type: .boolean, difficulty: .hard, question: "", correctAnswer: "", incorrectAnswers: [])
    var wholeAnswers: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        wholeAnswers.append(contentsOf: currentQuizQuestion.incorrectAnswers)
        wholeAnswers.append(currentQuizQuestion.correctAnswer)
        wholeAnswers.shuffle() // Swift 4.2 feature
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.questionTextView.text = decodeHTMLEntities(baseString: currentQuizQuestion.question)
        
    }
    
    func decodeHTMLEntities(baseString: String) -> String {
        
        guard let data = baseString.data(using: .utf8) else {
            return baseString
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return baseString
        }
        
        let decodedString = attributedString.string // The Weeknd ‘King Of The Fall’
        return decodedString
    }
    
    func popUpViewForAnswer(imageStr: String){
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        popOverVC.image = UIImage(named: imageStr)
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
        
    }
}

extension QuestionViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wholeAnswers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! QuestionsCollectionViewCell
        cell.populateCell(with: wholeAnswers[indexPath.row])
        return cell
    }
    
}

extension QuestionViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let questionPageController = self.parent as? TriviaPageViewController{
            if let currentIndex = questionPageController.questionPages.firstIndex(of: self){
                guard (questionPageController.questionPages.count - currentIndex) > 1 else{
                    NotificationCenter.default.post(name: NSNotification.Name(quizDone), object: self)
                    return
                }
                
                let correctAnswer = currentQuizQuestion.correctAnswer
                if (wholeAnswers[indexPath.row] == correctAnswer){
                    NotificationCenter.default.post(name: NSNotification.Name(answerWasCorrect), object: self)
                    popUpViewForAnswer(imageStr: "CorrectCheck")
                } else{
                    NotificationCenter.default.post(name: NSNotification.Name(answerWasIncorrect), object: self)
                    popUpViewForAnswer(imageStr: "IncorrectCheck")
                }
                
                //Check if this is the last question

                    // Wait a sec
                    let delayInSeconds = 1.0
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                        // Move on to next question.
                        let nextViewController = questionPageController.questionPages[currentIndex + 1]
                        questionPageController.setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
                    }
                
            }
        }
    }// end func collectionView
}
