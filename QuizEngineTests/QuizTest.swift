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
    
    func test_startQuiz_answerZeroOutTwoCorrectly_scoresZero() {
        let delegate = DelegateSpy()
        quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate)
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        
        XCTAssertEqual(delegate.completedQuiz.count, 1)
        assertEqual(a1: delegate.completedQuiz[0], a2:  ([("Q1", "A1"), ("Q2", "A2")]))
    }
    
    private func assertEqual(a1: [(String, String)],
                             a2: [(String, String)],
                             file: StaticString = #filePath,
                             line: UInt = #line) {
        XCTAssertTrue(a1.elementsEqual(a2, by: ==),
                      "\(a1) is not equal to \(a2)",
                      file: file,
                      line: line)
    }
    
    class DelegateSpy: QuizDeleget {
        var completedQuiz: [[(String, String)]] = []
        var answerCompletion: (String) -> Void = {_ in}
        
        func answer(for question: String, completion: @escaping (String) -> Void) {
            self.answerCompletion = completion
        }
        
        func didCompleteQuiz(withAnswers: [(question: String, answer: String)]) {
            completedQuiz.append(withAnswers)
        }
        
        func handle(result: QuizEngine.Resulte<String, String>) {}
    }
}
