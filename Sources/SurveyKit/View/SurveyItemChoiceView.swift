//
//  SurveyItemChoiceView.swift
//  SurveyTest (iOS)
//
//  Created by Andreas Hausberger on 27.05.21.
//

import SwiftUI

public struct SurveyItemChoiceView<I: SurveyItem>: SurveyItemView {
    typealias Item = I
    
    let index: Int
    var item: I
    let possibleValues: [Int]
    var leadingText: String = ""
    var trailingText: String = ""
    var didEnterAnswer: ((String) -> ())?
    @State var selectedValue: Int = 0
    public var body: some View {
        LazyVStack(alignment: .leading){
            Text("\(index). \(item.text)")
                .fontWeight(.bold)
                .font(.headline)
                .lineLimit(3)
            Picker(selection: $selectedValue, label: Text("Picker"), content: {
                ForEach(possibleValues, id: \.self) { value in
                    Text("\(value)").tag(value)
                }
            })
            .shadow(radius: 4)
            .onReceive([self.selectedValue].publisher.first(), perform: { value in
                self.didEnterAnswer?("\(value)")
            })
            .pickerStyle(SegmentedPickerStyle())
            HStack {
                Text(leadingText)
                    .multilineTextAlignment(.leading)
                Spacer()
                Text(trailingText)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}

struct SurveyItemChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        let exampleItem = SimpleSurveyItem(text: "How are you feeling today? This is a long Question. ", format: .Choice, value: "0")
        SurveyItemChoiceView(index: 0,
                             item: exampleItem,
                             possibleValues: [1, 2, 3, 4, 5],
                             leadingText: "Text on the left",
                             trailingText: "Text on the right",
                             didEnterAnswer: nil)
    }
}
