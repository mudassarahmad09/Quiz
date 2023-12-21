//
//  Quiz.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 21/12/2023.
//

import Foundation

public final class Quiz {
    
    let flow: Any
    
    init(flow: Any) {
        self.flow = flow
    }
    
    public static func start<Question, Answer: Equatable, Delegate: QuizDeleget>(questions: [Question], delegate: Delegate, correctAnswer: [Question: Answer]) -> Quiz where Delegate.Question == Question, Delegate.Answer == Answer {
        let flow = Flow(questions: questions, delegate: delegate, scoring: {
            socring($0, correctAnswer: correctAnswer)
        })
        flow.start()
        return Quiz(flow: flow)
    }
}
