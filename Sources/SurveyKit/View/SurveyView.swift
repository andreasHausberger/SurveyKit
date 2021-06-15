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
    @State var buttonIsDisabled: Bool = true
    @State var numberOfRequiredItems: Int = 0
    var numberOfCompletedItems: Int {
        self.answers.values.filter { $0 != "" && $0 != "0" && $0 != "0.0" }.count
    }
    
    public init(survey: Survey<I>, service: SurveyService<I>?, didSubmitSurvey: (() -> ())? = nil) {
        self.survey = survey
        self.service = service
        self.didSubmitSurvey = didSubmitSurvey
    }
    
    public var didSubmitSurvey: (() -> ())?
    public var body: some View {
        List {
            Section {
                Text(survey.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            Section {
                Text(survey.text)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .onAppear()
            }
            Section {
                VStack(spacing: 25) {
                    ForEach(0..<survey.items.count) { index in
                        let item: I = survey.items[index]
                        switch item.format {
                        case AnswerFormat.Freeform:
                            SurveyItemFreeFormView(index: index, item: item, didEnterAnswer: { answer in
                                self.acceptAnswerFor(item, answer: answer)
                            })
                            
                        case AnswerFormat.Choice:
                            SurveyItemChoiceView(index: index, item: item, possibleValues: item.possibleValues, didEnterAnswer: { answer in
                                self.acceptAnswerFor(item, answer: answer)
                            })
                            
                        case AnswerFormat.Continuous:
                            SurveyItemContinuousView(index: index, item: item, didEnterAnswer: { answer in
                                self.acceptAnswerFor(item, answer: answer)
                            })
                        }
                    }
                }
            }
            Section {
                VStack(alignment: .center) {
                    Button(action: {
                        self.service?.save(submission: self.answers)
                        self.didSubmitSurvey?()
                    }, label: {
                        Text("Submit")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(45)
                            .shadow(radius: 10)
                        }
                    )
                    .disabled(buttonIsDisabled)
                }
                .padding(.vertical)
            }
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
        if self.numberOfCompletedItems >= self.numberOfRequiredItems {
            self.buttonIsDisabled = false
        }
        else {
            self.buttonIsDisabled = true
        }
    }
}



struct SurveyView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyView<SimpleSurveyItem>(survey: SurveyService<SimpleSurveyItem>.createExampleSurvey(), service: nil)
    }
}
