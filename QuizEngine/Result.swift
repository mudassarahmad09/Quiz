//
//  Result.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 11/12/2023.
//

import Foundation

public struct Result<Question: Hashable, Answer> {
    public let answer: [Question: Answer]
    public let score: Int
}
