//
//  QuizTest.swift
//  QuizEngineTests
//
//  Created by Qazi Mudassar on 21/12/2023.
//

import XCTest
import QuizEngine

class QuizTestTest: XCTestCase {
    
    private let delegate = DelegateSpy()
    private var quiz: Game<String, String, DelegateSpy>!
    
    override func setUp() {
        super.setUp()
        quiz = startGame(questions: ["Q1", "Q2"], router: delegate, correctAnswer: ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startGame_answerZeroOutTwoCorrectly_scoresZero() {
        delegate.answerCallback("worng")
        delegate.answerCallback("worng")
        
        XCTAssertEqual(delegate.handleResult!.score, 0)
    }
    
    func test_startGame_answerOneOutTwoCorrectly_scoresOne() {
        delegate.answerCallback("A1")
        delegate.answerCallback("worng")
        
        XCTAssertEqual(delegate.handleResult!.score, 1)
    }
    
    func test_startGame_answerTwoOutTwoCorrectly_scoresTwo() {
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        XCTAssertEqual(delegate.handleResult!.score, 2)
    }
    
    private class DelegateSpy: Router {
        var handleResult: Resulte<String, String>? = nil
        var answerCallback: (String) -> Void = {_ in}
        
        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            self.answerCallback = answerCallback
        }
        
        func routeTo(result: Resulte<String, String>) {
            handleResult = result
        }
    }
}
