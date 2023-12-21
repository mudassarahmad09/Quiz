//
//  Flow.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 06/12/2023.
//

import Foundation

class Flow<Delegate: QuizDeleget> {
    
    typealias Question = Delegate.Question
    typealias Answer = Delegate.Answer
    
    private let questions: [Question]
    private let delegate: Delegate
    private var answers: [Question: Answer] = [:]
    private var scoring: ([Question: Answer]) -> Int
    
    init(questions: [Question], delegate: Delegate, scoring: @escaping ([Question: Answer]) -> Int) {
        self.questions = questions
        self.delegate = delegate
        self.scoring = scoring
    }
    
    func start() {
        if let firstQuestion = questions.first {
            delegate.answer(for: firstQuestion,
                           completion: nextCallback(from: firstQuestion))
        } else {
            delegate.handle(result: result())
        }
    }
    
    private func nextCallback(from question: Question) -> (Answer) -> Void {
         {[weak self]  in self?.delegateQuestionHandling(question, $0)}
    }
    
    private func delegateQuestionHandling(_ question: Question, _ answer: Answer) {
        guard let currentQuestionIndex = questions.firstIndex(of: question) else { return}
        answers[question] = answer
        
        let nextQuestionIndex = currentQuestionIndex + 1
        guard nextQuestionIndex < questions.count  else {
            delegate.handle(result: result())
            return
        }
        
        let nextQuestion = questions[nextQuestionIndex]
        delegate.answer(for: nextQuestion,
                       completion: nextCallback(from: nextQuestion))
    }
    
    private func result() -> Resulte<Question, Answer> {
        Resulte(answer: answers, score: scoring(answers))
    }
}
