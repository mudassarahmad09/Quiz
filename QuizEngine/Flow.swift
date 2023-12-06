//
//  Flow.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 06/12/2023.
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String) -> Void
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
    func routeTo(result: [String: String])
}

class Flow {
    private let questions: [String]
    private let router: Router
    private var result: [String: String] = [:]
    
    init(questions: [String],router: Router) {
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
    
    private func nextCallback(from question: String) -> Router.AnswerCallback {
         {[weak self]  in self?.routeNext(question, $0)}
    }
    
    private func routeNext(_ question: String, _ answer: String) {
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
