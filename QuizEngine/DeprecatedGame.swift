//
//  Game.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 11/12/2023.
//

import Foundation

@available(*, deprecated, message: "use QuizDelegate insted")
public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: Resulte<Question, Answer>)
}


@available(*, deprecated, message: "use Quiz insted")
public class Game<Question, Answer, R: Router> {
    let quiz: Quiz
    
    init(quiz: Quiz) {
        self.quiz = quiz
    }
}

@available(*, deprecated, message: "use Quiz.start insted")
public func startGame<Question, Answer: Equatable, R: Router>(questions: [Question], router: R, correctAnswer: [Question: Answer]) -> Game<Question, Answer, R> where R.Question == Question, R.Answer == Answer {
    let adpter =  QuizDelegateToRouterAdpter(router, correctAnswer)
    let quiz = Quiz.start(questions: questions, delegate: adpter)
    return Game(quiz: quiz)
}

@available(*, deprecated)
private class QuizDelegateToRouterAdpter<R: Router>: QuizDeleget where R.Answer: Equatable {
    private let router: R
    private let correctAnswers: [R.Question : R.Answer]
    
    init(_ router: R, _ correctAnswers: [R.Question : R.Answer]) {
        self.router = router
        self.correctAnswers = correctAnswers
    }
    
    func answer(for question: R.Question, completion: @escaping (R.Answer) -> Void) {
        router.routeTo(question: question, answerCallback: completion)
    }
    
    func didCompleteQuiz(withAnswers answer: [(question: R.Question, answer: R.Answer)]) {
        let answerDictionary = answer.reduce([R.Question: R.Answer]()) { acc, tuple in
            var acc = acc
            acc[tuple.question] = tuple.answer
            return acc
        }
        let score =  socring(answerDictionary, correctAnswer: correctAnswers)
        let result = Resulte(answer: answerDictionary, score: score)
        router.routeTo(result: result)
    }
    
    private func socring(_ answers: [R.Question: R.Answer], correctAnswer: [R.Question: R.Answer]) -> Int {
        return answers.reduce(0) { (socre, tuple) in
            return socre + (correctAnswer[tuple.key] == tuple.value ? 1 : 0)
        }
    }
    
}

@available(*, deprecated, message: "Socreing is not avaible now")
public struct Resulte<Question: Hashable, Answer> {
    public var answer: [Question: Answer]
    public var score: Int
    
}
