//
//  QuizTest.swift
//  QuizEngineTests
//
//  Created by Qazi Mudassar on 21/12/2023.
//

import XCTest
@testable import QuizEngine

final class Quiz {
    
    let flow: Any
    
    init(flow: Any) {
        self.flow = flow
    }
    
    static func start<Question, Answer: Equatable, Delegate: QuizDeleget>(questions: [Question], delegate: Delegate, correctAnswer: [Question: Answer]) -> Quiz where Delegate.Question == Question, Delegate.Answer == Answer {
        let flow = Flow(questions: questions, delegate: delegate, scoring: {
            socring($0, correctAnswer: correctAnswer)
        })
        flow.start()
        return Quiz(flow: flow)
    }
}

class QuizTestTest: XCTestCase {
    
    private let delegate = DelegateSpy()
    private var quiz: Quiz!
    
    override func setUp() {
        super.setUp()
        quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate, correctAnswer: ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startQuiz_answerZeroOutTwoCorrectly_scoresZero() {
        delegate.answerCallback("worng")
        delegate.answerCallback("worng")
        
        XCTAssertEqual(delegate.handleResult!.score, 0)
    }
    
    func test_startQuiz_answerOneOutTwoCorrectly_scoresOne() {
        delegate.answerCallback("A1")
        delegate.answerCallback("worng")
        
        XCTAssertEqual(delegate.handleResult!.score, 1)
    }
    
    func test_startQuiz_answerTwoOutTwoCorrectly_scoresTwo() {
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        XCTAssertEqual(delegate.handleResult!.score, 2)
    }
    
    private class DelegateSpy: QuizDeleget {
        var handleResult: Resulte<String, String>? = nil
        var answerCallback: (String) -> Void = {_ in}
        
        func handle(question: String, answerCallback: @escaping (String) -> Void) {
            self.answerCallback = answerCallback
        }
        
        func handle(result: Resulte<String, String>) {
            handleResult = result
        }
    }
}
