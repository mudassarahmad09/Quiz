//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Qazi Mudassar on 05/12/2023.
//

import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
    func test_start_withNoQuestion_doesNotRouterToQuestion  () {
        makeSUT(questions: []).start()
        XCTAssertTrue(delegate.handleQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion() {
        makeSUT(questions: ["Q1"]).start()
        XCTAssertEqual(delegate.handleQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        makeSUT(questions: ["Q2"]).start()
        XCTAssertEqual(delegate.handleQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion() {
        makeSUT(questions: ["Q1","Q2"]).start()
        XCTAssertEqual(delegate.handleQuestions, ["Q1"])
    }
    
    func test_startTwic_withTwoQuestions_routesToFirstQuestionTwice() {
        let sut =  makeSUT(questions: ["Q1","Q2"])
        sut.start()
        sut.start()
        XCTAssertEqual(delegate.handleQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstQuestionAndSecondQuestion_withThreeQuestions_routesToSecondAndThirdQuestion() {
        let sut =  makeSUT(questions: ["Q1","Q2","Q3"])
        sut.start()
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        XCTAssertEqual(delegate.handleQuestions, ["Q1","Q2","Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestions_doesNotRouteToAnotherQuestion() {
        let sut =  makeSUT(questions: ["Q1"])
        sut.start()
        delegate.answerCallback("A1")
        XCTAssertEqual(delegate.handleQuestions, ["Q1"])
    }
    
    func test_start_withNoQuestion_routerToResult  () {
        makeSUT(questions: []).start()
        XCTAssertEqual(delegate.handleResult!.answer, [:])
    }
    
    func test_start_withOneQuestion_doesNotRouterToResult  () {
        makeSUT(questions: ["Q1"]).start()
        XCTAssertNil(delegate.handleResult)
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestion_doesNotRouterToResult() {
        let sut =  makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        delegate.answerCallback("A1")
        XCTAssertNil(delegate.handleResult)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_routesToResult() {
        let sut =  makeSUT(questions: ["Q1","Q2"])
        sut.start()
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        XCTAssertEqual(delegate.handleResult!.answer, ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_scores() {
        let sut =  makeSUT(questions: ["Q1","Q2"], scoring: {_ in 10})
        sut.start()
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        XCTAssertEqual(delegate.handleResult!.score, 10)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_scoresWithRightAnswer() {
        var recivedAnswer = [String: String]()
        let sut =  makeSUT(questions: ["Q1","Q2"], scoring: { answer in
            recivedAnswer = answer
            return 20})
        sut.start()
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
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
        let sut = Flow(questions: questions, router: delegate,scoring: scoring)
        weakSUT = sut
        return sut
    }
    
    class DelegateSpy: Router, QuizDeleget {
        var handleQuestions: [String] = []
        var handleResult: Resulte<String, String>? = nil
        var answerCallback: (String) -> Void = {_ in}
        
        func handle(question: String, answerCallback: @escaping (String) -> Void) {
            handleQuestions.append(question)
            self.answerCallback = answerCallback
        }
        
        func handle(result: QuizEngine.Resulte<String, String>) {
            handleResult = result
        }
        
        
        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            handle(question: question, answerCallback: answerCallback)
        }
        
        func routeTo(result: Resulte<String, String>) {
            handle(result: result)
        }
    }
}
