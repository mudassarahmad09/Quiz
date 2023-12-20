//
//  GameTest.swift
//  QuizEngineTests
//
//  Created by Qazi Mudassar on 11/12/2023.
//

import XCTest
import QuizEngine

@available(*, deprecated)
class DeprecatedGameTest: XCTestCase {
    
    private let router = RouterSpy()
    private var game: Game<String, String, RouterSpy>!
    
    override func setUp() {
        super.setUp()
        game = startGame(questions: ["Q1", "Q2"], router: router, correctAnswer: ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startGame_answerZeroOutTwoCorrectly_scoresZero() {
        router.answerCallback("worng")
        router.answerCallback("worng")
        
        XCTAssertEqual(router.routedResult!.score, 0)
    }
    
    func test_startGame_answerOneOutTwoCorrectly_scoresOne() {
        router.answerCallback("A1")
        router.answerCallback("worng")
        
        XCTAssertEqual(router.routedResult!.score, 1)
    }
    
    func test_startGame_answerTwoOutTwoCorrectly_scoresTwo() {
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedResult!.score, 2)
    }
    
    private class RouterSpy: Router {
        var routedResult: Resulte<String, String>? = nil
        var answerCallback: (String) -> Void = {_ in}
        
        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            self.answerCallback = answerCallback
        }
        
        func routeTo(result: Resulte<String, String>) {
            routedResult = result
        }
    }
}
