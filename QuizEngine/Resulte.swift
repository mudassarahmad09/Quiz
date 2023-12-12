//
//  Result.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 11/12/2023.
//

import Foundation

public struct Resulte<Question: Hashable, Answer>: Hashable {
    public var answer: [Question: Answer]
    public var score: Int
    
    public init(answer: [Question : Answer], score: Int) {
        self.answer = answer
        self.score = score
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(score)
    }
    
    public static func == (lhs: Resulte<Question, Answer>, rhs: Resulte<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}
