//
//  Game.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 11/12/2023.
//

import Foundation

public class Game<Question: Hashable, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    let flow: Flow<Question, Answer, R>
    
    init(flow: Flow<Question, Answer, R>) {
        self.flow = flow
    }
}

public func startGame<Question: Hashable, Answer: Equatable, R: Router>(questions: [Question], router: R, correctAnswer: [Question: Answer]) -> Game<Question, Answer, R> where R.Question == Question, R.Answer == Answer {
    let flow = Flow(questions: questions, router: router, scoring: {
        socring($0, correctAnswer: correctAnswer)
    })
    flow.start()
    return Game(flow: flow)
}

private func socring<Question: Hashable, Answer: Equatable>(_ answers: [Question: Answer], correctAnswer: [Question: Answer]) -> Int {
    return answers.reduce(0) { (socre, tuple) in
        return socre + (correctAnswer[tuple.key] == tuple.value ? 1 : 0)
    }
}