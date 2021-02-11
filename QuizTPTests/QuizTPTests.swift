//
//  QuizTPTests.swift
//  QuizTPTests
//
//  Created by OUDJAMA Moussa (Canal Plus) on 27/12/2020.
//

import XCTest
@testable import QuizTP

class QuizTPTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitQuestion(){
        let question = Question(question: "Ou suis-je", reponse: "Test", choix: ["choix1","choix2","choix3","choix4"], anecdote: "Il est ou")
        XCTAssertNotNil(question)
    }
    
    func testQuestionGoodAnswer(){
        let question = Question(question: "Ou suis-je", reponse: "Test", choix: ["choix1","choix2","choix3","choix4"], anecdote: "Il est ou")
        let answer = question.choix[1]
        let goodAnswer = "choix2"
        XCTAssertTrue(answer == goodAnswer)
    }

    func testQuestionBadAnswer(){
        let question = Question(question: "Ou suis-je", reponse: "Test", choix: ["choix1","choix2","choix3","choix4"], anecdote: "Il est ou")
        let answer = question.choix[1]
        let goodAnswer = "3"
        XCTAssertFalse(answer == goodAnswer)
    }
    
    func testInMemoryRequestNotNil(){
        let questionRequester = InMemoryQuestionService()
        questionRequester.getQuestionFor(categorie: "questionSample", completionHandler: { question in
            XCTAssertNotNil(question)
        })
    }
    
    func testInMemoryRequestNoResponse(){
        let questionRequester = InMemoryQuestionService()
        questionRequester.getQuestionFor(categorie: "noQuestionSample", completionHandler: { question in
            XCTAssertNil(question)
        })
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
