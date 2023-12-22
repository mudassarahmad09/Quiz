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
        XCTAssertTrue(delegate.handleQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_delegateToCorrectQuestionHandling() {
        makeSUT(questions: ["Q1"]).start()
        XCTAssertEqual(delegate.handleQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_delegateAnotherCorrectQuestionHandling() {
        makeSUT(questions: ["Q2"]).start()
        XCTAssertEqual(delegate.handleQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_delegateFirstQuestionHandling() {
        makeSUT(questions: ["Q1","Q2"]).start()
        XCTAssertEqual(delegate.handleQuestions, ["Q1"])
    }
    
    func test_startTwic_withTwoQuestions_delegateFirstQuestionHandlingTwice() {
        let sut =  makeSUT(questions: ["Q1","Q2"])
        sut.start()
        sut.start()
        XCTAssertEqual(delegate.handleQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstQuestionAndSecondQuestion_withThreeQuestions_delegateSecondAndThirdQuestionHandling() {
        let sut =  makeSUT(questions: ["Q1","Q2","Q3"])
        sut.start()
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        XCTAssertEqual(delegate.handleQuestions, ["Q1","Q2","Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestions_doesNotDelegateAnotherQuestionHandling() {
        let sut =  makeSUT(questions: ["Q1"])
        sut.start()
        delegate.answerCompletion("A1")
        XCTAssertEqual(delegate.handleQuestions, ["Q1"])
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
        delegate.answerCompletion("A1")
        XCTAssertTrue(delegate.completedQuiz.isEmpty)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_completeQuiz() {
        let sut =  makeSUT(questions: ["Q1","Q2"])
        sut.start()
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        
        XCTAssertEqual(delegate.completedQuiz.count, 1)
        assertEqual(a1: delegate.completedQuiz[0], a2:  ([("Q1", "A1"), ("Q2", "A2")]))
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_scores() {
        let sut =  makeSUT(questions: ["Q1","Q2"], scoring: {_ in 10})
        sut.start()
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        XCTAssertEqual(delegate.handleResult!.score, 10)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_scoresWithRightAnswer() {
        var recivedAnswer = [String: String]()
        let sut =  makeSUT(questions: ["Q1","Q2"], scoring: { answer in
            recivedAnswer = answer
            return 20})
        sut.start()
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        XCTAssertEqual(recivedAnswer, ["Q1": "A1", "Q2": "A2"])
    }
    
    // MARK: - Helper
    
    private let delegate = DelegateSpy()
    private weak var weakSUT: Flow< DelegateSpy >?
    
    override func tearDown() {
        super.tearDown()
        XCTAssertNil(weakSUT, "Memory Leak detected. Weak refernce to the SUT instance is not nil")
    }
    
    func makeSUT(questions: [String],
                 scoring: @escaping ([String: String]) -> Int = {_ in 0}) -> Flow< DelegateSpy > {
        let sut = Flow(questions: questions, delegate: delegate,scoring: scoring)
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
        var handleQuestions: [String] = []
        var handleResult: Resulte<String, String>? = nil
        var completedQuiz: [[(String, String)]] = []
        var answerCompletion: (String) -> Void = {_ in}
        
        func answer(for question: String, completion: @escaping (String) -> Void) {
            handleQuestions.append(question)
            self.answerCompletion = completion
        }
        
        func didCompleteQuiz(withAnswers: [(question: String, answer: String)]) {
            completedQuiz.append(withAnswers)
        }
        
        func handle(result: QuizEngine.Resulte<String, String>) {
            handleResult = result
        }
    }
}
