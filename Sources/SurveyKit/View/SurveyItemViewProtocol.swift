//
//  SurveyItemViewProtocol.swift
//  SurveyTest (iOS)
//
//  Created by Andreas Hausberger on 27.05.21.
//

import Foundation
import SwiftUI


protocol SurveyItemView: View {
    associatedtype Item: SurveyItem
    var index: Int { get }
    var item: Item { get }
    var didEnterAnswer: ((String) -> ())? { get set }
}
