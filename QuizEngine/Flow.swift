//
//  Flow.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 06/12/2023.
//

import Foundation

protocol Router {
    func routeTo(question: String, answerCallback: @escaping (String) -> Void)
}

class Flow {
    let questions: [String]
    let router: Router
    
    init(questions: [String],router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion) {[weak self] _ in
                guard let self else { return }
                let firstQuestionIndex = self.questions.firstIndex(of: firstQuestion)!
                let secondQuestion = self.questions[firstQuestionIndex+1]
                router.routeTo(question: secondQuestion) { _ in
                    
                }
            }
        }
    }
}
