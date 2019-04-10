//
//  TriviaPageViewController.swift
//  OTGTrivia
//
//  Created by Julio Reyes on 4/3/19.
//  Copyright © 2019 Julio Reyes. All rights reserved.
//

import UIKit

class TriviaPageViewController: UIPageViewController {
    @IBOutlet var resultsViewModel: ResultsViewModel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var questionPages: [UIViewController] = []
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(goToResultsScreen), name: NSNotification.Name(quizDone), object: nil)
        
        self.activityIndicator.center = self.view.center
        self.downloadQuizData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.questionPages = []
        self.resultsViewModel.rcleanViewModel()
    }
    
    func downloadQuizData(){
        self.resultsViewModel.loadingStatus = { [weak self]() in
            DispatchQueue.main.async {
                let isLoading = self?.resultsViewModel.isLoading ?? false
                if isLoading{
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.view.alpha = 0.0
                    })
                } else{
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.view.alpha = 1.0
                    })
                }
            }
        }
        self.resultsViewModel.getQuiz {
            //  set up pages for UIPageViewController
            DispatchQueue.main.async {
                    self.dataSource = self
                    self.delegate = self
                    self.isPagingEnabled = false

                    self.setUpPages()
            }
        }
    }
    
    func setUpPages(){
        guard self.resultsViewModel.quizList.count > 1 else {
            fatalError("Game cannot exist.")
        }
        for question in self.resultsViewModel.quizList{
            guard let questionPageInstance = self.getViewController(withIdentifier: "QuestionViewController") as? QuestionViewController else{
                return
            }
            questionPageInstance.currentQuizQuestion = question
            self.questionPages.append(questionPageInstance)
        }
        
        if let firstQuestionViewController = questionPages.first{
            setViewControllers([firstQuestionViewController], direction: .forward, animated: false, completion: nil)
        }
    }
    
    @objc func goToResultsScreen(){
        // Go to the final results screen
        self.performSegue(withIdentifier: "QuizCompleteIdentifier", sender: self)
    }

    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "QuizCompleteIdentifier"{
            let finalResultsVC = segue.destination as! FinalResultsViewController
            let correct = self.resultsViewModel.correctAnswersHit
            let incorrect = self.resultsViewModel.incorrectAnswersHit
            let difficulty = self.resultsViewModel.getDifficulty(from: self.resultsViewModel.quizList[0])
            let gameType = self.resultsViewModel.getGameType(from: self.resultsViewModel.quizList[0])
            let score = (100 * correct) - (50 * incorrect)
            let scoreData = ["difficulty": difficulty,"correct" : correct, "incorrect": incorrect, "score": score, "gametype" : gameType] as [String : Any]
            finalResultsVC.finalScoreData = scoreData
        }
    }
 

}

// I wanted to prevent users from scrolling through the page view controller
// Using a PageViewController was the first method of approach to this project
extension UIPageViewController {
    var isPagingEnabled: Bool {
        get {
            var isEnabled: Bool = true
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    isEnabled = subView.isScrollEnabled
                }
            }
            return isEnabled
        }
        set {
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    subView.isScrollEnabled = newValue
                }
            }
        }
    }
}

extension TriviaPageViewController: UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        self.isPagingEnabled = false
        guard let viewControllerIndex = questionPages.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0          else { return questionPages.last }
        
        guard questionPages.count > previousIndex else { return nil        }
        
        return questionPages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        self.isPagingEnabled = true
        guard let viewControllerIndex = questionPages.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < questionPages.count else { return questionPages.first }
        
        guard questionPages.count > nextIndex else { return nil         }
        
        return questionPages[nextIndex]
    }
}

extension TriviaPageViewController: UIPageViewControllerDelegate{
    
}
