//
//  QuizDelegate.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 21/12/2023.
//

import Foundation

public protocol QuizDeleget {
    associatedtype Question
    associatedtype Answer
    
    func answer(for question: Question, completion: @escaping (Answer) -> Void)
    func didCompleteQuiz(withAnswers:[(question: Question, answer: Answer)])
}

