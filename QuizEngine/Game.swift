//
//  Game.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 11/12/2023.
//

import Foundation

@available(*, deprecated)
public class Game<Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    let flow: Flow<R>
    
    init(flow: Flow<R>) {
        self.flow = flow
    }
}

@available(*, deprecated)
public func startGame<Question, Answer: Equatable, R: Router>(questions: [Question], router: R, correctAnswer: [Question: Answer]) -> Game<Question, Answer, R> where R.Question == Question, R.Answer == Answer {
    let flow = Flow(questions: questions, router: router, scoring: {
        socring($0, correctAnswer: correctAnswer)
    })
    flow.start()
    return Game(flow: flow)
}

private func socring<Question, Answer: Equatable>(_ answers: [Question: Answer], correctAnswer: [Question: Answer]) -> Int {
    return answers.reduce(0) { (socre, tuple) in
        return socre + (correctAnswer[tuple.key] == tuple.value ? 1 : 0)
    }
}
