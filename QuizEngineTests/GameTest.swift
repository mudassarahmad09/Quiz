//
//  GameTest.swift
//  QuizEngineTests
//
//  Created by Qazi Mudassar on 11/12/2023.
//

import XCTest
import QuizEngine

class GameTest: XCTestCase {
    
    let router = RouterSpy()
    var game: Game<String, String, RouterSpy>!
    
    override func setUp() {
        super.setUp()
        game = startGame(questions: ["Q1", "Q2"], router: router, correctAnswer: ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startGame_answerZeroOutTwoCorrectly_scoresZero() {
        router.answerCallback("worng")
        router.answerCallback("worng")
        
        XCTAssertEqual(router.routedResult!.score, 0)
    }
    
    func test_startGame_answerOneOutTwoCorrectly_scoresOne() {
        router.answerCallback("A1")
        router.answerCallback("worng")
        
        XCTAssertEqual(router.routedResult!.score, 1)
    }
    
    func test_startGame_answerTwoOutTwoCorrectly_scoresTwo() {
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedResult!.score, 2)
    }
}
