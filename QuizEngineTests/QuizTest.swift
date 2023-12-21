//
//  QuizTest.swift
//  QuizEngineTests
//
//  Created by Qazi Mudassar on 21/12/2023.
//

import XCTest
import QuizEngine

class QuizTestTest: XCTestCase {
    
    private let delegate = RouterSpy()
    private var game: Game<String, String, RouterSpy>!
    
    override func setUp() {
        super.setUp()
        game = startGame(questions: ["Q1", "Q2"], router: delegate, correctAnswer: ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startGame_answerZeroOutTwoCorrectly_scoresZero() {
        delegate.answerCallback("worng")
        delegate.answerCallback("worng")
        
        XCTAssertEqual(delegate.routedResult!.score, 0)
    }
    
    func test_startGame_answerOneOutTwoCorrectly_scoresOne() {
        delegate.answerCallback("A1")
        delegate.answerCallback("worng")
        
        XCTAssertEqual(delegate.routedResult!.score, 1)
    }
    
    func test_startGame_answerTwoOutTwoCorrectly_scoresTwo() {
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        XCTAssertEqual(delegate.routedResult!.score, 2)
    }
    
    private class RouterSpy: Router {
        var routedResult: Resulte<String, String>? = nil
        var answerCallback: (String) -> Void = {_ in}
        
        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            self.answerCallback = answerCallback
        }
        
        func routeTo(result: Resulte<String, String>) {
            routedResult = result
        }
    }
}
