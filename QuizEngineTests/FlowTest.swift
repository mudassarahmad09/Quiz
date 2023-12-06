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
        let router = RouterSpy()
        let flow = Flow(questions: [], router: router)
        flow.start()
        XCTAssertTrue(router.routerQuestions.isEmpty)
    }
        
    func test_start_withOneQuestion_routesToCorrectQuestion() {
        let router = RouterSpy()
        let flow = Flow(questions: ["Q1"], router: router)
        flow.start()
        XCTAssertEqual(router.routerQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        let router = RouterSpy()
        let flow = Flow(questions: ["Q2"], router: router)
        flow.start()
        XCTAssertEqual(router.routerQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion() {
        let router = RouterSpy()
        let flow = Flow(questions: ["Q1","Q2"], router: router)
        flow.start()
        XCTAssertEqual(router.routerQuestions, ["Q1"])
    }
    
    func test_startTwic_withTwoQuestions_routesToFirstQuestionTwice() {
        let router = RouterSpy()
        let flow = Flow(questions: ["Q1","Q2"], router: router)
        flow.start()
        flow.start()
        XCTAssertEqual(router.routerQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_routesToSecondQuestion() {
        let router = RouterSpy()
        let flow = Flow(questions: ["Q1","Q2"], router: router)
        flow.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routerQuestions, ["Q1","Q2"])
    }
    
    class RouterSpy: Router {
        var routerQuestions: [String] = []
        var answerCallback: (String) -> Void = {_ in}
        
        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            routerQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }
}
