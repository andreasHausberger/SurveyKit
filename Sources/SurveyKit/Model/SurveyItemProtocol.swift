//
//  SurveyItemProtocol.swift
//  SurveyTest (iOS)
//
//  Created by Andreas Hausberger on 12.05.21.
//

import Foundation

public protocol SurveyItem: Hashable {
    var itemID: AnyHashable { get set }
    var text: String { get set }
    var format: AnswerFormat { get set }
    var value: String? { get set }
    var isRequired: Bool { get set }
    var possibleValues: [AnyHashable] { get set }
    var minimum: Double { get set }
    var maximum: Double { get set }
}

public enum AnswerFormat {
    case Freeform
    case Choice
    case Continuous
}
