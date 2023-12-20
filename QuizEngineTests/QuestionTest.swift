//
//  Created by Qazi Mudassar on 12/12/2023.
//

import XCTest
@testable import QuizEngine

class QuestionTest: XCTestCase {
    
    func test_hashValue_withSameWrappedValue_isDifferentForSingleAndMultipleAnswer() {
        
        let aValue = UUID()
        XCTAssertNotEqual(Question.single(aValue).hashValue, Question.multiple(aValue).hashValue)
    }
    
    func test_hashValue_forSingleAnswer() {
        let aValue = UUID()
        let anotherValue = UUID()
        XCTAssertEqual(Question.single(aValue).hashValue, Question.single(aValue).hashValue)
        
        XCTAssertNotEqual(Question.single(aValue).hashValue, Question.single(anotherValue).hashValue)
    }
    
    func test_hashValue_forMultipleAnswer() {
        
        let aValue = UUID()
        let anotherValue = UUID()
        XCTAssertEqual(Question.multiple(aValue).hashValue, Question.multiple(aValue).hashValue)
        
        XCTAssertNotEqual(Question.multiple(aValue).hashValue, Question.multiple(anotherValue).hashValue)
    }
}
