//
//  Question.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 12/12/2023.
//

import Foundation

public enum Question<T: Hashable>: Hashable{
    case single(T)
    case multiple(T)
}
