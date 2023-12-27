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
    
    func test_oneCorrectOneWorngAnswer_scoreOne() {
        let score = BasicScore.score(
            for: ["correct 1","worng"],
            comparingTo: ["correct 1","correct2"])
        XCTAssertEqual(score, 1)
    }
    
    private class BasicScore {
        static func score(for answers: [String], comparingTo correctAnswers: [String]) -> Int {
            var score = 0
            for (index, answer) in answers.enumerated() {
                score += (answer == correctAnswers[index]) ? 1 : 0
            }
            return score
       }
    }
}
