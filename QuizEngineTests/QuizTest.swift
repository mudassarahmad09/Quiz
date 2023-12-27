//
//  QuizTest.swift
//  QuizEngineTests
//
//  Created by Qazi Mudassar on 21/12/2023.
//

import XCTest
import QuizEngine

class QuizTestTest: XCTestCase {
    
    private var quiz: Quiz!
    
    func test_startQuiz_answerAllQuestions_completesQithAnswers() {
        let delegate = DelegateSpy()
        quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate)
        delegate.answerCompletions[0]("A1")
        delegate.answerCompletions[1]("A2")
        
        XCTAssertEqual(delegate.completedQuiz.count, 1)
        assertEqual(a1: delegate.completedQuiz[0], a2:  ([("Q1", "A1"), ("Q2", "A2")]))
    }
    
    func test_startQuiz_answerAllQuestionsTwice_completesQithAnswers() {
        let delegate = DelegateSpy()
        quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate)
        delegate.answerCompletions[0]("A1")
        delegate.answerCompletions[1]("A2")
        
        delegate.answerCompletions[0]("A1-1")
        delegate.answerCompletions[1]("A2-2")
        
        XCTAssertEqual(delegate.completedQuiz.count, 2)
        assertEqual(a1: delegate.completedQuiz[0], a2:  ([("Q1", "A1"), ("Q2", "A2")]))
        assertEqual(a1: delegate.completedQuiz[1], a2:  ([("Q1", "A1-1"), ("Q2", "A2-2")]))
    }
}
