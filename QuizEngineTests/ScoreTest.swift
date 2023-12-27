//
//  ScoreTest.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 27/12/2023.
//

import XCTest

class ScoreTest: XCTestCase {
    func test_noAnswer_scoreZero() {
        XCTAssertEqual(BasicScore.score(for: []), 0)
    }
    
    private class BasicScore {
       static func score(for: [Any]) -> Int {
           0
       }
    }
}
