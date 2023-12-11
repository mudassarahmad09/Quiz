//
//  GameTest.swift
//  QuizEngineTests
//
//  Created by Qazi Mudassar on 11/12/2023.
//

import XCTest
import QuizEngine

class GameTest: XCTest {
    func test_startGame_answerOneOutTwoCorrectly_scores1() {
        let router = RouterSpy()
        startGame(questions: ["Q1, Q2"], router: router, correctAnswer: ["Q1": "A1", "Q2": "A2"])
        router.answerCallback("A1")
        router.answerCallback("worng")
        XCTAssertEqual(router.routedResult!.score, 1)
    }
}
