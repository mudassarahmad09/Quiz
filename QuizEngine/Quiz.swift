//
//  Quiz.swift
//  QuizEngine
//
//  Created by Qazi Mudassar on 21/12/2023.
//

import Foundation

public final class Quiz {
    
    let flow: Any
    
    init(flow: Any) {
        self.flow = flow
    }
    
    public static func start<Delegate: QuizDeleget>(
        questions: [Delegate.Question],
        delegate: Delegate
    ) -> Quiz where Delegate.Answer: Equatable{
        let flow = Flow(questions: questions,delegate: delegate)
        flow.start()
        return Quiz(flow: flow)
    }
}

