//
//  Created by Qazi Mudassar on 11/12/2023.
//

import Foundation

public protocol QuizDeleget {
    associatedtype Question: Hashable
    associatedtype Answer
    func handle(question: Question, answerCallback: @escaping (Answer) -> Void)
    func handle(result: Resulte<Question, Answer>)
}

@available(*, deprecated)
public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: Resulte<Question, Answer>)
}
