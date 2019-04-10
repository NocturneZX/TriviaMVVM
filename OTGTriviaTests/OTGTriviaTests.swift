//
//  OTGTriviaTests.swift
//  OTGTriviaTests
//
//  Created by Julio Reyes on 4/3/19.
//  Copyright © 2019 Julio Reyes. All rights reserved.
//

import XCTest
@testable import OTGTrivia

class OTGTriviaTests: XCTestCase {

    var testResultsViewModel: ResultsViewModel?
    var mockResultList: [Results]
    var mockAPIService: APIClientService?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mockAPIService = APIClientService()
        testResultsViewModel = ResultsViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        testResultsViewModel = nil
        mockAPIService = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        
    }
    
    func testNetworkCall(){
        let vM = self.testResultsViewModel!
        let service = self.mockAPIService!
        let expectation = XCTestExpectation(description: "Got callback")
        try! service.getQuizResultsData {
            expectation.fulfill()
            print(vM.quizList.count)
            XCTAssertTrue(vM.quizList.count >= 10)
            for question in vM.quizList{
                XCTAssertNotNil(question.self)
            }
        }
        wait(for: [expectation], timeout: 3.1)
    }
    
    func testModel(){
        let testQuizJSON: Dictionary = ["category":"Entertainment: Video Games","type":"multiple","difficulty":"hard","question":"What is now Bungie's popular game?","correct_answer":"Destiny","incorrect_answers":["Halo","Monolith","Riven"]] as [String : Any]
        
        let testData: Data = try! NSKeyedArchiver.archivedData(withRootObject: testQuizJSON, requiringSecureCoding: false)
        
        let testDecoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            testDecoder.dateDecodingStrategy = .iso8601
        }
        
        XCTAssertNoThrow(try? testDecoder.decode(Results.self, from: testData))
        
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
