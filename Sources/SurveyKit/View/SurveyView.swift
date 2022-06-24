//
//  SurveyView.swift
//  SurveyTest (iOS)
//
//  Created by Andreas Hausberger on 16.05.21.
//

import SwiftUI

public struct SurveyView<I: SurveyItem>: View {
    let service: SurveyService<I>?
    @State var survey: Survey<I>
    @State var answers: Dictionary<I, String> = [:]
    @State var numberOfRequiredItems: Int = 0
    
    var submitButtonText: String
    var numberOfCompletedItems: Int {
        self.answers.values.filter { $0 != "" && $0 != "0" && $0 != "0.0" }.count
    }
    
    public init(survey: Survey<I>, service: SurveyService<I>?, submitButtonText: String = "Submit", didSubmitSurvey: (() -> ())? = nil) {
        self.survey = survey
        self.service = service
        self.submitButtonText = submitButtonText
        self.didSubmitSurvey = didSubmitSurvey
    }
    
    public var didSubmitSurvey: (() -> ())?
    public var body: some View {
        NavigationView {
            List {
                Section {
                    Text(survey.text)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
                Section {
                    VStack(spacing: 25) {
                        surveyItems
                    }
                }
                submitButton
            }
            .navigationTitle(survey.title)
        }
        .onAppear {
            let requiredItems = self.survey.items.filter( { $0.isRequired })
            numberOfRequiredItems = requiredItems.count
            requiredItems.forEach { item in
                self.answers[item] = "";
            }
        }
    }
    
    func acceptAnswerFor(_ item: I, answer: String) {
        print("Number of completed Items: \(self.numberOfCompletedItems)")
        self.answers[item] = answer
    }
    
    var submitButton: some View {
        Button {
            self.service?.save(submission: self.answers)
            self.didSubmitSurvey?()
        } label: {
            Text(submitButtonText)
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity)
        }
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(45)
        .shadow(radius: 10)
        .frame(maxWidth: .infinity)
    }
    
    var surveyItems: some View {
        ForEach(0..<survey.items.count) { index in
            let item: I = survey.items[index]
            let indexPlusOne = index + 1
            switch item.format {
            case AnswerFormat.Freeform:
                SurveyItemFreeFormView(index: indexPlusOne, item: item, didEnterAnswer: { answer in
                    self.acceptAnswerFor(item, answer: answer)
                })
                
            case AnswerFormat.Choice:
                SurveyItemChoiceView(index: indexPlusOne, item: item, possibleValues: item.possibleValues, didEnterAnswer: { answer in
                    self.acceptAnswerFor(item, answer: answer)
                })
                
            case AnswerFormat.Continuous:
                SurveyItemContinuousView(index: indexPlusOne, item: item, didEnterAnswer: { answer in
                    self.acceptAnswerFor(item, answer: answer)
                })
            }
        }
    }
}



struct SurveyView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyView<SimpleSurveyItem>(survey: SurveyService<SimpleSurveyItem>.createExampleSurvey(), service: nil)
    }
}
