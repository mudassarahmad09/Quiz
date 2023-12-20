//
//  Flow.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 06/12/2023.
//

import Foundation

class Flow< R: Router> {
    
    typealias Question = R.Question
    typealias Answer = R.Answer
    
    private let questions: [Question]
    private let router: R
    private var answers: [Question: Answer] = [:]
    private var scoring: ([Question: Answer]) -> Int
    
    init(questions: [Question], router: R, scoring: @escaping ([Question: Answer]) -> Int) {
        self.questions = questions
        self.router = router
        self.scoring = scoring
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion,
                           answerCallback: nextCallback(from: firstQuestion))
        } else {
            router.routeTo(result: result())
        }
    }
    
    private func nextCallback(from question: Question) -> (Answer) -> Void {
         {[weak self]  in self?.routeNext(question, $0)}
    }
    
    private func routeNext(_ question: Question, _ answer: Answer) {
        guard let currentQuestionIndex = questions.firstIndex(of: question) else { return}
        answers[question] = answer
        
        let nextQuestionIndex = currentQuestionIndex + 1
        guard nextQuestionIndex < questions.count  else {
            router.routeTo(result: result())
            return
        }
        
        let nextQuestion = questions[nextQuestionIndex]
        router.routeTo(question: nextQuestion,
                       answerCallback: nextCallback(from: nextQuestion))
    }
    
    private func result() -> Resulte<Question, Answer> {
        Resulte(answer: answers, score: scoring(answers))
    }
}
