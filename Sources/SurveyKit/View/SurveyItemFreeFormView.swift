//
//  SurveyItemFreeFormView.swift
//  SurveyTest (iOS)
//
//  Created by Andreas Hausberger on 27.05.21.
//

import SwiftUI

public struct SurveyItemFreeFormView<I: SurveyItem>: SurveyItemView {
    typealias Item = I
    
    let index: Int
    let item: Item
    public var didEnterAnswer: ((String) -> ())? = nil
    
    
    @State var answer: String = ""
    public var body: some View {
        VStack(alignment: .leading){
            Text("\(index). \(item.text)")
                .fontWeight(.bold)
                .font(.headline)
            TextField("Ihre Antwort", text: $answer)
                .padding()
                .background(Color.gray.opacity(0.125))
                .cornerRadius(10)
                .onReceive([answer].publisher.first(), perform: { value in
                    print("entered: \(value)")
                    self.didEnterAnswer?(value)
                })
        }
    }
}

struct SurveyItemFreeFormView_Preview: PreviewProvider {
    static var previews: some View {
        SurveyItemFreeFormView<SimpleSurveyItem>(index: 1, item: SimpleSurveyItem(text: "Das ist ein Beispiel.", format: .Freeform))
    }
    
}
