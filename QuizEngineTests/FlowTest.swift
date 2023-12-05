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
        XCTAssertEqual(router.routerQuestionCount, 0)
    }
    
    func test_start_withOneQuestion_routerToQuestion() {
        let router = RouterSpy()
        let flow = Flow(questions: ["Q1"], router: router)
        flow.start()
        XCTAssertEqual(router.routerQuestionCount, 1)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion() {
        let router = RouterSpy()
        let flow = Flow(questions: ["Q1"], router: router)
        flow.start()
        XCTAssertEqual(router.routerQuestion, "Q1")
    }
    
    class RouterSpy: Router {
        var routerQuestionCount: Int = 0
        var routerQuestion: String? = nil
        
        func routeTo(question: String) {
            routerQuestionCount += 1
            routerQuestion = question
        }
    }
}
