//
//  Game.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 11/12/2023.
//

import Foundation

@available(*, deprecated)
public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: Resulte<Question, Answer>)
}


@available(*, deprecated)
public class Game<Question, Answer, R: Router> {
    let flow: Any
    
    init(flow: Any) {
        self.flow = flow
    }
}

@available(*, deprecated)
public func startGame<Question, Answer: Equatable, R: Router>(questions: [Question], router: R, correctAnswer: [Question: Answer]) -> Game<Question, Answer, R> where R.Question == Question, R.Answer == Answer {
    let flow = Flow(questions: questions, delegate: QuizDelegateToRouterAdpter(router), scoring: {
        socring($0, correctAnswer: correctAnswer)
    })
    flow.start()
    return Game(flow: flow)
}

@available(*, deprecated)
private class QuizDelegateToRouterAdpter<R: Router>: QuizDeleget {
    private let router: R
    
    init(_ router: R) {
        self.router = router
    }
    
    func handle(question: R.Question, answerCallback: @escaping (R.Answer) -> Void) {
        router.routeTo(question: question, answerCallback: answerCallback)
    }
    
    func handle(result: Resulte<R.Question, R.Answer>) {
        router.routeTo(result: result)
    }
}

func socring<Question, Answer: Equatable>(_ answers: [Question: Answer], correctAnswer: [Question: Answer]) -> Int {
    return answers.reduce(0) { (socre, tuple) in
        return socre + (correctAnswer[tuple.key] == tuple.value ? 1 : 0)
    }
}
