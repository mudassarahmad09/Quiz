//
//  Result.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 11/12/2023.
//

import Foundation

public struct Resulte<Question: Hashable, Answer> {
    public var answer: [Question: Answer]
    public var score: Int
}
