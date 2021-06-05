//
//  Survey.swift
//  SurveyTest (iOS)
//
//  Created by Andreas Hausberger on 12.05.21.
//

import Foundation

public class Survey<I: SurveyItem> {
    public init(title: String, text: String, items: [I] = []) {
        self.title = title
        self.text = text
        self.items = items
    }
    
    public init(title: String, text: String) {
        self.title = title
        self.text = text
    }
    
    public var title: String
    public var text: String
    public var items: [I] = []
    
}
