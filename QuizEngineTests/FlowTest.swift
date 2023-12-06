//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Qazi Mudassar on 05/12/2023.
//

import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
    
    let router = RouterSpy()
    
    func test_start_withNoQuestion_doesNotRouterToQuestion  () {
        makeSUT(questions: []).start()
        XCTAssertTrue(router.routerQuestions.isEmpty)
    }
        
    func test_start_withOneQuestion_routesToCorrectQuestion() {
        makeSUT(questions: ["Q1"]).start()
        XCTAssertEqual(router.routerQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        makeSUT(questions: ["Q2"]).start()
        XCTAssertEqual(router.routerQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion() {
        makeSUT(questions: ["Q1","Q2"]).start()
        XCTAssertEqual(router.routerQuestions, ["Q1"])
    }
    
    func test_startTwic_withTwoQuestions_routesToFirstQuestionTwice() {
        let sut =  makeSUT(questions: ["Q1","Q2"])
        sut.start()
        sut.start()
        XCTAssertEqual(router.routerQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_routesToSecondQuestion() {
        let sut =  makeSUT(questions: ["Q1","Q2"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routerQuestions, ["Q1","Q2"])
    }
    
    // MARK: - Helper
    func makeSUT(questions: [String]) -> Flow {
        Flow(questions: questions, router: router)
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
