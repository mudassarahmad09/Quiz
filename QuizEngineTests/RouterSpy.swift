//
//  Created by Qazi Mudassar on 11/12/2023.
//

import Foundation
import QuizEngine

class RouterSpy: Router {
    var routedQuestions: [String] = []
    var routedResult: Resulte<String, String>? = nil
    var answerCallback: (String) -> Void = {_ in}
    
    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }
    
    func routeTo(result: Resulte<String, String>) {
        routedResult = result
    }
}
