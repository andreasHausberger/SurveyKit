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
    let possibleValues: [AnyHashable]
    var leadingText: String = ""
    var trailingText: String = ""
    var didEnterAnswer: ((String) -> ())?
    var selectionText: String = "Auswahl: "
    @State var selectedValue: Int = -1
    public var body: some View {
        LazyVStack(alignment: .leading){
            Text("\(index). \(item.text)")
                .fontWeight(.bold)
                .font(.headline)
                .lineLimit(3)
            Picker(selection: $selectedValue, label: Text(selectionText + "\(String(describing: self.getSelectedValue()))"), content: {
                ForEach(1..<possibleValues.count + 1) { index in
                    let label = possibleValues[index - 1]
                    Text(String(describing: label))
                        .font(.footnote)
                        .tag(index)
                }
            })
//            .shadow(radius: 4)
            .onReceive([self.selectedValue].publisher.first(), perform: { value in
                let adjustedValue = value + 1
                if adjustedValue > 0 {
                    self.didEnterAnswer?("\(adjustedValue)")
                }
            })
            .pickerStyle(MenuPickerStyle())
            HStack {
                Text(leadingText)
                    .multilineTextAlignment(.leading)
                Spacer()
                Text(trailingText)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
    
    private func getSelectedValue() -> String {
        if self.selectedValue == -1 {
            return ""
        }
        if let string = self.possibleValues[selectedValue] as? String {
            return string
        }
        return ""
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
