//
//  ScoreTest.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 27/12/2023.
//

import XCTest

class ScoreTest: XCTestCase {
    func test_noAnswer_scoreZero() {
        XCTAssertEqual(BasicScore.score(for: [], comparingTo: []), 0)
    }
    
    func test_oneWorngAnswer_scoreZero() {
        XCTAssertEqual(BasicScore.score(for: ["worng"], comparingTo: ["correct"]), 0)
    }
    
    func test_oneCorrectAnswer_scoreOne() {
        XCTAssertEqual(BasicScore.score(for: ["correct"], comparingTo: ["correct"]), 1)
    }
    
    private class BasicScore {
        static func score(for answers: [String], comparingTo correctAnswers: [String]) -> Int {
            if answers.isEmpty { return 0}
            return answers == correctAnswers ? 1 : 0
       }
    }
}
