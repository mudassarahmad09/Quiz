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
}

class Flow {
    private let questions: [String]
    private let router: Router
    
    init(questions: [String],router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion,
                           answerCallback: routeNext(from: firstQuestion))
        }
    }
    
    private func routeNext(from question: String) -> Router.AnswerCallback {
        return {[weak self] _ in
            guard let self else { return }
            guard let currentQuestionIndex = self.questions.firstIndex(of: question) else { return}
            guard currentQuestionIndex+1 < self.questions.count  else { return}
            let nextQuestion = self.questions[currentQuestionIndex+1]
            router.routeTo(question: nextQuestion,
                           answerCallback: routeNext(from: nextQuestion))
        }
    }
}
