//
//  Result.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 11/12/2023.
//

import Foundation

struct Result<Question: Hashable, Answer> {
    let answer: [Question: Answer]
    let score: Int
}
