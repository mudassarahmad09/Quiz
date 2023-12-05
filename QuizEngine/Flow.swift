//
//  Flow.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 06/12/2023.
//

import Foundation

protocol Router {
    func routeTo(question: String)
}

class Flow {
    let questions: [String]
    let router: Router
    
    init(questions: [String],router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if !questions.isEmpty {
            router.routeTo(question: "Q1")
        }
    }
}
