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
    private var quiz: Quiz!
    
    override func setUp() {
        super.setUp()
        quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate, correctAnswer: ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startQuiz_answerZeroOutTwoCorrectly_scoresZero() {
        delegate.answerCompletion("worng")
        delegate.answerCompletion("worng")
        
        XCTAssertEqual(delegate.handleResult!.score, 0)
    }
    
    func test_startQuiz_answerOneOutTwoCorrectly_scoresOne() {
        delegate.answerCompletion("A1")
        delegate.answerCompletion("worng")
        
        XCTAssertEqual(delegate.handleResult!.score, 1)
    }
    
    func test_startQuiz_answerTwoOutTwoCorrectly_scoresTwo() {
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        XCTAssertEqual(delegate.handleResult!.score, 2)
    }
    
    private class DelegateSpy: QuizDeleget {
        var handleResult: Resulte<String, String>? = nil
        var answerCompletion: (String) -> Void = {_ in}
        
        func answer(for question: String, completion: @escaping (String) -> Void) {
            self.answerCompletion = completion
        }
        
        func handle(result: Resulte<String, String>) {
            handleResult = result
        }
    }
}
