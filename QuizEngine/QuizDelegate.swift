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
    func didCompleteQuiz(withAnswers:[(question: Question, answer: Answer)])
    
    @available(*, deprecated, message: "use the didCompleteQuiz(withAnswers:) insted")
    func handle(result: Resulte<Question, Answer>)
}

#warning("Delete this at some point")
extension QuizDeleget {
    func didCompleteQuiz(withAnswers:[(question: Question, answer: Answer)]){}
}
