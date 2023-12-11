//
//  Flow.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 06/12/2023.
//

import Foundation

protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: [Question: Answer])
}

class Flow<Question: Hashable, Answer, R: Router> where R.Question == Question, R.Answer ==  Answer {
    private let questions: [Question]
    private let router: R
    private var result: [Question: Answer] = [:]
    
    init(questions: [Question], router: R) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion,
                           answerCallback: nextCallback(from: firstQuestion))
        } else {
            router.routeTo(result: result)
        }
    }
    
    private func nextCallback(from question: Question) -> (Answer) -> Void {
         {[weak self]  in self?.routeNext(question, $0)}
    }
    
    private func routeNext(_ question: Question, _ answer: Answer) {
        guard let currentQuestionIndex = questions.firstIndex(of: question) else { return}
        result[question] = answer
        
        let nextQuestionIndex = currentQuestionIndex + 1
        guard nextQuestionIndex < questions.count  else {
            router.routeTo(result: result)
            return
        }
        
        let nextQuestion = questions[nextQuestionIndex]
        router.routeTo(question: nextQuestion,
                       answerCallback: nextCallback(from: nextQuestion))
    }
}
