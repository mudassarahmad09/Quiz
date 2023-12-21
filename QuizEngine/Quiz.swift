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

func socring<Question, Answer: Equatable>(_ answers: [Question: Answer], correctAnswer: [Question: Answer]) -> Int {
    return answers.reduce(0) { (socre, tuple) in
        return socre + (correctAnswer[tuple.key] == tuple.value ? 1 : 0)
    }
}
