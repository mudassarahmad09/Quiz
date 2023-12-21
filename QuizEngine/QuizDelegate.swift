//
//  QuizDelegate.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 21/12/2023.
//

import Foundation

public protocol QuizDeleget {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func answer(for question: Question, completion: @escaping (Answer) -> Void)
    func handle(result: Resulte<Question, Answer>)
}
