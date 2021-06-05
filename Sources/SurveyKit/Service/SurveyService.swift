//
//  SurveyService.swift
//  SurveyTest (iOS)
//
//  Created by Andreas Hausberger on 16.05.21.
//

import Foundation

public class SurveyService {
    
    public static func createExampleSurvey() -> Survey<SimpleSurveyItem> {
        let items: [SimpleSurveyItem] = [
            SimpleSurveyItem(text: "What is your first name?", format: .Freeform, value: nil),
            SimpleSurveyItem(text: "What is your last name?", format: .Freeform, value: nil),
            SimpleSurveyItem(text: "On a scale from 1-7, how much do you like hedgehogs?", format: .Choice, value: nil, possibleValues: [1, 2, 3, 4, 5, 6, 7]),
            SimpleSurveyItem(text: "On a scale from 1-10, how much do you like squirrels?", format: .Continuous, minimum: 0, maximum: 10)
        ]
        return Survey(title: "First Survey", text: "This is a test to check out how this may look when implemented in a view. This text may be long or shot, but should never be boring. ", items: items)
    }
}
