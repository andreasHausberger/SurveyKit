//
//  SimpleSurveyItem.swift
//  SurveyTest (iOS)
//
//  Created by Andreas Hausberger on 16.05.21.
//

import Foundation

public struct SimpleSurveyItem: SurveyItem {
    
    public init(itemID: Int = 0, text: String, format: AnswerFormat, value: String? = nil, isRequired: Bool = true, possibleValues: [AnyHashable] = [], minimum: Double = 0, maximum: Double = 0, leadingLabel: String = "", trailingLabel: String = "") {
        self.itemID = itemID
        self.text = text
        self.format = format
        self.value = value
        self.possibleValues = possibleValues
        self.minimum = minimum
        self.maximum = maximum
        self.isRequired = isRequired
        self.leadingLabel = leadingLabel
        self.trailingLabel = trailingLabel
        
        switch format {
        case .Choice:
            if self.possibleValues == [] {
                fatalError("Choice Items must have possible values!")
            }
        case .Continuous:
            if self.minimum == 0 && self.maximum == 0 {
                fatalError("Continuous Items must have valid minimum and maximum values!")
            }
            break
        default:
            break
        }
    }
    
    public var itemID: AnyHashable
    public var text: String
    public var format: AnswerFormat
    public var value: String?
    public var isRequired: Bool
    public var possibleValues: [AnyHashable] = []
    public var minimum: Double
    public var maximum: Double
    var leadingLabel: String = ""
    var trailingLabel: String = ""
    
    mutating func saveAnswer(answer: String) {
        self.value = answer
    }
}
