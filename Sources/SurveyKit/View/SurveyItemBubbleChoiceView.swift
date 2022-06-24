//
//  SwiftUIView.swift
//  
//index: indexPlusOne, item: item, possibleValues: item.possibleValues, didEnterAnswer: { answer in
//self.acceptAnswerFor(item, answer: answer)

//  Created by rise on 24.06.22.
//

import SwiftUI

struct SurveyItemBubbleChoiceView<I: SurveyItem>: SurveyItemView {
    typealias Item = I
    var index: Int = 0
    var item: Item
    var possibleValues: [AnyHashable]
    var didEnterAnswer: ((String) -> ())?

    @State var selected: String = ""
    
    init(index: Int, item: Item, possibleValues: [AnyHashable], didEnterAnswer: @escaping ((String) -> ())) {
        self.index = index
        self.item = item
        self.possibleValues = possibleValues
        self.didEnterAnswer = didEnterAnswer
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Current Selection: \(selected)")
            Text(item.text)
                .padding()
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<possibleValues.count) { index in
                        let value = possibleValues[index].toString()
                        ChoiceBubble(value)
                            .selectable(active: selected == value)
                            .onTapGesture {
                                selected = value
                                self.didEnterAnswer?(selected)
                            }
                    }
                }
                .padding()
            }
        }
    }
}

struct ChoiceBubble: View {
    var content: String
    var color: Color
    
    init(_ content: String, color: Color = .blue) {
        self.content = content
        self.color = color
    }
    var body: some View {
        Text(content)
            .fontWeight(.bold)
            .padding(25)
            .background(color)
            .cornerRadius(72)
    }
}
