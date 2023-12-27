//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Qazi Mudassar on 05/12/2023.
//

import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
    func test_start_withNoQuestion_doesNotDelegateToQuestionHandling() {
        makeSUT(questions: []).start()
        XCTAssertTrue(delegate.questionsAsked.isEmpty)
    }
    
    func test_start_withOneQuestion_delegateToCorrectQuestionHandling() {
        makeSUT(questions: ["Q1"]).start()
        XCTAssertEqual(delegate.questionsAsked, ["Q1"])
    }
    
    func test_start_withOneQuestion_delegateAnotherCorrectQuestionHandling() {
        makeSUT(questions: ["Q2"]).start()
        XCTAssertEqual(delegate.questionsAsked, ["Q2"])
    }
    
    func test_start_withTwoQuestions_delegateFirstQuestionHandling() {
        makeSUT(questions: ["Q1","Q2"]).start()
        XCTAssertEqual(delegate.questionsAsked, ["Q1"])
    }
    
    func test_startTwic_withTwoQuestions_delegateFirstQuestionHandlingTwice() {
        let sut =  makeSUT(questions: ["Q1","Q2"])
        sut.start()
        sut.start()
        XCTAssertEqual(delegate.questionsAsked, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstQuestionAndSecondQuestion_withThreeQuestions_delegateSecondAndThirdQuestionHandling() {
        let sut =  makeSUT(questions: ["Q1","Q2","Q3"])
        sut.start()
        delegate.answerCompletions[0]("A1")
        delegate.answerCompletions[1]("A2")
        XCTAssertEqual(delegate.questionsAsked, ["Q1","Q2","Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestions_doesNotDelegateAnotherQuestionHandling() {
        let sut =  makeSUT(questions: ["Q1"])
        sut.start()
        delegate.answerCompletions[0]("A1")
        XCTAssertEqual(delegate.questionsAsked, ["Q1"])
    }
    
    func test_start_withNoQuestion_completeWithEmptyQuiz() {
        makeSUT(questions: []).start()
        XCTAssertEqual(delegate.completedQuiz.count, 1)
        XCTAssertTrue(delegate.completedQuiz[0].isEmpty)
    }
    
    func test_start_withOneQuestion_doesNotCompleteQuiz() {
        makeSUT(questions: ["Q1"]).start()
        XCTAssertTrue(delegate.completedQuiz.isEmpty)
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestion_doesNotCompleteQuiz() {
        let sut =  makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        delegate.answerCompletions[0]("A1")
        XCTAssertTrue(delegate.completedQuiz.isEmpty)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_completeQuiz() {
        let sut =  makeSUT(questions: ["Q1","Q2"])
        sut.start()
        delegate.answerCompletions[0]("A1")
        delegate.answerCompletions[1]("A2")
        
        XCTAssertEqual(delegate.completedQuiz.count, 1)
        assertEqual(a1: delegate.completedQuiz[0], a2:  ([("Q1", "A1"), ("Q2", "A2")]))
    }
    
    func test_startAndAnswerFirstAndSecondQuestionTwice_withTwoQuestions_completeQuizTwice() {
        let sut =  makeSUT(questions: ["Q1","Q2"])
        sut.start()
        delegate.answerCompletions[0]("A1")
        delegate.answerCompletions[1]("A2")
        
        delegate.answerCompletions[0]("A1-1")
        delegate.answerCompletions[1]("A2-2")
        
        XCTAssertEqual(delegate.completedQuiz.count, 2)
        assertEqual(a1: delegate.completedQuiz[0], a2:  ([("Q1", "A1"), ("Q2", "A2")]))
        assertEqual(a1: delegate.completedQuiz[1], a2:  ([("Q1", "A1-1"), ("Q2", "A2-2")]))
    }
        
    // MARK: - Helper
    
    private let delegate = DelegateSpy()
    private weak var weakSUT: Flow< DelegateSpy >?
    
    override func tearDown() {
        super.tearDown()
        XCTAssertNil(weakSUT, "Memory Leak detected. Weak refernce to the SUT instance is not nil")
    }
    
    func makeSUT(questions: [String]) -> Flow< DelegateSpy > {
        let sut = Flow(questions: questions, delegate: delegate)
        weakSUT = sut
        return sut
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
        var questionsAsked: [String] = []
        var completedQuiz: [[(String, String)]] = []
        var answerCompletions: [(String) -> Void] = []
        
        func answer(for question: String, completion: @escaping (String) -> Void) {
            questionsAsked.append(question)
            self.answerCompletions.append(completion)
        }
        
        func didCompleteQuiz(withAnswers: [(question: String, answer: String)]) {
            completedQuiz.append(withAnswers)
        }

    }
}
