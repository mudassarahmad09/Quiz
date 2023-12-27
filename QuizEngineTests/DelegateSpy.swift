//
//  DelegateSpy.swift
//  QuizEngineTests
//
//  Created by Qazi Mudassar on 27/12/2023.
//

import XCTest
import QuizEngine

class DelegateSpy: QuizDeleget {
    var questionsAsked: [String] = []
    var completedQuiz: [[(String, String)]] = []
    var answerCompletions: [(String) -> Void] = []
    
    func answer(for question: String, completion: @escaping (String) -> Void) {
        questionsAsked.append(question)
        self.answerCompletions.append(completion)
    }
    
    func didCompleteQuiz(withAnswers: [(question: String, answer: String)]) {
        completedQuiz.append(withAnswers)
    }

}
