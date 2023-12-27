//
//  Assertions.swift
//  QuizEngineTests
//
//  Created by Qazi Mudassar on 27/12/2023.
//

import XCTest

func assertEqual(a1: [(String, String)],
                         a2: [(String, String)],
                         file: StaticString = #filePath,
                         line: UInt = #line) {
    XCTAssertTrue(a1.elementsEqual(a2, by: ==),
                  "\(a1) is not equal to \(a2)",
                  file: file,
                  line: line)
}
